module surov (
    input logic clk,
    input logic rst,

    output word_t  mem_addr,
    output logic mem_rden,
    output logic mem_wren,
    output mem_addr_t mem_size,
    input  word_t memread_data,
    output word_t memwrite_data,

    output trap
);
    ctrl_t ctrl;
    logic done;
    logic branch_taken;
    logic forward;

    opcode_t opcode;
    opcode_t next_opcode;

    logic[1:0] cycle /*verilator public*/;

    regnum_t  regnum;
    word_t rfread_data;
    word_t rfwrite_data;
    logic rf_wren;

    cntr_t cntr_addr;
    word_t cntr_data;

    word_t mem_latch;
    always_ff @( posedge clk ) begin
        mem_latch <= memread_data;
    end


    rf #(.WORD_SIZE(`XLEN), .REG_COUNT(`REG_COUNT)) r  (
        .clk(clk),
        .we(rf_wren),
        .addr(regnum),
        .wdata(rfwrite_data),
        .rdata(rfread_data)
    );

    datapath dp (
        .clk(clk),
        .rst(rst),
        .ctrl(ctrl),
        .done(done),
        .branch_taken(branch_taken),
        .forward(forward),
        .opcode(opcode),
        .next_opcode(next_opcode),
        .regnum(regnum),
        .rfread_data(rfread_data),
        .rfwrite_data(rfwrite_data),
        .cntr_addr(cntr_addr),
        .cntr_data(cntr_data),
        .mem_addr(mem_addr),
        .mem_size(mem_size),
        .memread_data(mem_latch),
        .memwrite_data(memwrite_data)
    );

    control cp (
        .clk(clk),
        .rst(rst),
        .opcode(opcode),
        .next_opcode(next_opcode),
        .done(done),
        .branch_taken(branch_taken),
        .forward_taken(forward),
        .ctrl(ctrl),
        .rf_wren(rf_wren),
        .mem_rden(mem_rden),
        .mem_wren(mem_wren),
        .cycle(cycle),
        .trap(trap)
    );

    cntrs cn (
        .clk(clk),
        .rst(rst),
        .cycle(cycle),
        .start(ctrl.start),
        .addr(cntr_addr),
        .data(cntr_data)
    );
endmodule

module surov_wrapper #(
    parameter SRAM_SIZE = 4096,  // 4KB SRAM
    parameter ADDR_WIDTH = $clog2(SRAM_SIZE),
    parameter DATA_WIDTH = 32    // Assuming word_t is 32-bit
) (
    input  logic clk,
    input  logic rst,
    output logic trap
);

    // Signals between surov and SRAM
    logic [DATA_WIDTH-1:0] mem_addr;
    logic mem_rden;
    logic mem_wren;
    logic [2:0] mem_size;  // mem_addr_t enum
    logic [DATA_WIDTH-1:0] memread_data;
    logic [DATA_WIDTH-1:0] memwrite_data;
    
    // SRAM registered inputs
    logic [ADDR_WIDTH-1:0] sram_addr_reg;
    logic sram_rden_reg;
    logic sram_wren_reg;
    logic [2:0] sram_size_reg;
    logic [DATA_WIDTH-1:0] sram_wdata_reg;
    
    // SRAM storage
    logic [DATA_WIDTH-1:0] sram_mem [0:SRAM_SIZE/4-1];  // Byte-addressable as words
    
    // SRAM output
    logic [DATA_WIDTH-1:0] sram_rdata;
    
    // Instantiate surov module
    surov surov_inst (
        .clk(clk),
        .rst(rst),
        .mem_addr(mem_addr),
        .mem_rden(mem_rden),
        .mem_wren(mem_wren),
        .mem_size(mem_size),
        .memread_data(memread_data),
        .memwrite_data(memwrite_data),
        .trap(trap)
    );
    
    // Register SRAM inputs
    always_ff @(posedge clk) begin
        if (rst) begin
            sram_addr_reg <= '0;
            sram_rden_reg <= 1'b0;
            sram_wren_reg <= 1'b0;
            sram_size_reg <= 3'b0;
            sram_wdata_reg <= '0;
        end else begin
            sram_addr_reg <= mem_addr[ADDR_WIDTH-1:0];
            sram_rden_reg <= mem_rden;
            sram_wren_reg <= mem_wren;
            sram_size_reg <= mem_size;
            sram_wdata_reg <= memwrite_data;
        end
    end
    
    // SRAM read/write logic (operates on registered inputs)
    always_ff @(posedge clk) begin
        if (sram_wren_reg) begin
            case (sram_size_reg)
                3'b000, 3'b100: begin  // MEM_B, MEM_BU - byte
                    case (sram_addr_reg[1:0])
                        2'b00: sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]][7:0]   <= sram_wdata_reg[7:0];
                        2'b01: sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]][15:8]  <= sram_wdata_reg[7:0];
                        2'b10: sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]][23:16] <= sram_wdata_reg[7:0];
                        2'b11: sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]][31:24] <= sram_wdata_reg[7:0];
                    endcase
                end
                3'b001, 3'b101: begin  // MEM_H, MEM_HU - halfword
                    case (sram_addr_reg[1])
                        1'b0: sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]][15:0]  <= sram_wdata_reg[15:0];
                        1'b1: sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]][31:16] <= sram_wdata_reg[15:0];
                    endcase
                end
                3'b010: begin  // MEM_W - word
                    sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]] <= sram_wdata_reg;
                end
            endcase
        end
    end
    
    assign sram_rdata = sram_rden_reg ? sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]]: 'x;
    
    // Sign/zero extension for reads
    always_comb begin
        case (sram_size_reg)
            3'b000: begin  // MEM_B - signed byte
                case (sram_addr_reg[1:0])
                    2'b00: memread_data = {{24{sram_rdata[7]}},  sram_rdata[7:0]};
                    2'b01: memread_data = {{24{sram_rdata[15]}}, sram_rdata[15:8]};
                    2'b10: memread_data = {{24{sram_rdata[23]}}, sram_rdata[23:16]};
                    2'b11: memread_data = {{24{sram_rdata[31]}}, sram_rdata[31:24]};
                endcase
            end
            3'b100: begin  // MEM_BU - unsigned byte
                case (sram_addr_reg[1:0])
                    2'b00: memread_data = {24'b0, sram_rdata[7:0]};
                    2'b01: memread_data = {24'b0, sram_rdata[15:8]};
                    2'b10: memread_data = {24'b0, sram_rdata[23:16]};
                    2'b11: memread_data = {24'b0, sram_rdata[31:24]};
                endcase
            end
            3'b001: begin  // MEM_H - signed halfword
                case (sram_addr_reg[1])
                    1'b0: memread_data = {{16{sram_rdata[15]}}, sram_rdata[15:0]};
                    1'b1: memread_data = {{16{sram_rdata[31]}}, sram_rdata[31:16]};
                endcase
            end
            3'b101: begin  // MEM_HU - unsigned halfword
                case (sram_addr_reg[1])
                    1'b0: memread_data = {16'b0, sram_rdata[15:0]};
                    1'b1: memread_data = {16'b0, sram_rdata[31:16]};
                endcase
            end
            3'b010: begin  // MEM_W - word
                memread_data = sram_rdata;
            end
            default: memread_data = '0;
        endcase
    end

endmodule