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
    logic sram_wren_reg;
    logic sram_sign_reg;
    logic [DATA_WIDTH-1:0] sram_mask_reg;
    logic [DATA_WIDTH-1:0] sram_wdata_reg;
    
    // SRAM storage
    logic [DATA_WIDTH-1:0] sram_mem [0:SRAM_SIZE/4-1];  // Byte-addressable as words
    
    // SRAM output
    logic [DATA_WIDTH-1:0] sram_rdata;

    // SRAM mask
    logic[DATA_WIDTH-1:0] sram_mask;
    
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

    
    
    // Generate SRAM mask based on mem_size and mem_addr
    always_comb begin
        unique case (mem_size[1:0])
            2'b00: begin  // MEM_B, MEM_BU - byte access
                case (mem_addr[1:0])
                    2'b00: sram_mask = 32'h000000FF;  // byte 0 (LSB)
                    2'b01: sram_mask = 32'h0000FF00;  // byte 1
                    2'b10: sram_mask = 32'h00FF0000;  // byte 2
                    2'b11: sram_mask = 32'hFF000000;  // byte 3 (MSB)
                endcase
            end
            2'b01: begin  // MEM_H, MEM_HU - halfword access
                case (mem_addr[1])
                    1'b0: sram_mask = 32'h0000FFFF;   // lower halfword
                    1'b1: sram_mask = 32'hFFFF0000;   // upper halfword
                endcase
            end
            2'b10: begin  // MEM_W - word access
                sram_mask = 32'hFFFFFFFF;             // full word
            end
            default: sram_mask = 32'hx;        // invalid size
        endcase
    end

    // Register SRAM inputs
    always_ff @(posedge clk) begin
        sram_wren_reg  <= mem_wren;
        if (mem_rden | mem_wren) begin
            sram_addr_reg  <= mem_addr[ADDR_WIDTH-1:0];
            sram_sign_reg  <= mem_size[2];
            sram_mask_reg  <= sram_mask;
            sram_wdata_reg <= memwrite_data;
        end
    end

    // SRAM read/write logic (operates on registered inputs)
    always_ff @(posedge clk) begin
        if (sram_wren_reg) begin
            // Write using a for loop and bitwise mask
            for (int i = 0; i < DATA_WIDTH; i++) begin
                if (sram_mask_reg[i])
                    sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]][i] <= sram_wdata_reg[i + sram_addr_reg[1:0]*8];
            end
        end
    end
    
    assign sram_rdata = sram_mem[sram_addr_reg[ADDR_WIDTH-1:2]];
    
    // Sign/zero extension for reads
    always_comb begin
        // Use sram_mask_reg to select which bytes/halfwords to extend
        unique case (sram_mask_reg)
            32'h000000FF: memread_data = {sram_sign_reg ? 24'b0 : {24{sram_rdata[7]}},  sram_rdata[7:0]};
            32'h0000FF00: memread_data = {sram_sign_reg ? 24'b0 : {24{sram_rdata[15]}}, sram_rdata[15:8]};
            32'h00FF0000: memread_data = {sram_sign_reg ? 24'b0 : {24{sram_rdata[23]}}, sram_rdata[23:16]};
            32'hFF000000: memread_data = {sram_sign_reg ? 24'b0 : {24{sram_rdata[31]}}, sram_rdata[31:24]};
            32'h0000FFFF: memread_data = {sram_sign_reg ? 16'b0 : {16{sram_rdata[15]}}, sram_rdata[15:0]};
            32'hFFFF0000: memread_data = {sram_sign_reg ? 16'b0 : {16{sram_rdata[31]}}, sram_rdata[31:16]};
            32'hFFFFFFFF: memread_data = sram_rdata;
            default:      memread_data = 'X;
        endcase
    end

endmodule