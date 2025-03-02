module chip #(
    parameter int NUMREGS=32,
    localparam WDATA = 32,
    localparam WPTR = 32,
    localparam WSHAM = 5,
    localparam WRFI = $clog2(NUMREGS)
)(
    input logic clk,
    input logic rst,
    output logic out_en,
    output logic[WDATA-1] out
);
    cycle_t cycle;

    logic rf_read;
    logic rf_wren;
    logic[WRFI-1:0]  regnum;
    logic[WDATA-1:0] rfread_data;
    logic[WDATA-1:0] rfwrite_data;

    logic mem_read;
    logic mem_wren;
    logic[WPTR-1:0]  mem_addr;
    mem_addr_t mem_size;
    logic[WDATA-1:0] memread_data;
    logic[WDATA-1:0] memwrite_data;

    logic[WDATA-1:0] regfile[0:NUMREGS-1];
    logic[WDATA-1:0] memory[0:15];

    core c(clk, rst, cycle,
         rf_read, rf_wren, regnum, rfread_data, rfwrite_data,
         mem_read, mem_wren, mem_addr, mem_size, memread_data, memwrite_data);

    always_comb begin
        rfread_data = regfile[regnum];
        memread_data = memory[mem_addr[5:2]];
    end

    always_ff @(posedge clk) begin
        out_en <= (mem_addr == 'h8000000);
        if (rf_wren && regnum != 0)
            regfile[regnum] <= rfwrite_data;
        if (mem_wren) begin
            if (mem_addr == 'h8000000)
                out <= memwrite_data;
            else
                memory[mem_addr[5:2]] <= memwrite_data;
        end
    end
    endmodule

