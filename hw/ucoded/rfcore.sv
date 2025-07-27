module rfcore #(
    parameter int NUMREGS=32,
    localparam WDATA = 32,
    localparam WPTR = 32,
    localparam WSHAM = 5,
    localparam WRFI = $clog2(NUMREGS)
)(
    input logic clk,
    input logic rst,
    
    output logic mem_read,
    output logic mem_wren,
    output logic[WPTR-1:0]  mem_addr,
    output mem_addr_t mem_size,
    input  logic[WDATA-1:0] memread_data,
    output logic[WDATA-1:0] memwrite_data,

    output logic host_trap
);
    logic rf_read;
    logic rf_wren;
    logic[WRFI-1:0]  regnum;
    logic[WDATA-1:0] rfread_data;
    logic[WDATA-1:0] rfwrite_data;

    logic[WDATA-1:0] regfile[0:NUMREGS-1] /*verilator public*/;

    core c(clk, rst,
        rf_read, rf_wren, regnum, rfread_data, rfwrite_data,
        mem_read, mem_wren, mem_addr, mem_size, memread_data, memwrite_data, host_trap);

    always_comb begin
        rfread_data = regfile[regnum];
    end

    always_ff @(posedge clk) begin
        if (rf_wren && regnum != 0)
            regfile[regnum] <= rfwrite_data;
    end
endmodule

