module rf #(
    parameter XLEN = 32,
    parameter REG_COUNT = 32
)(
    input  wire                      clk,
    input  wire                      we,       // Write enable
    input  wire [$clog2(REG_COUNT)-1:0] addr,   // Address for both read and write
    input  wire [XLEN-1:0]     wdata,    // Data to write
    output reg [XLEN-1:0]     rdata     // Data to read
);

    reg [XLEN - 1 : 0] regfile [REG_COUNT - 1 : 0] /*verilator public*/;
    always @(posedge clk)
        if (we)
            regfile[addr] <= wdata;
    assign rdata = (addr == 0) ? '0 : regfile[addr];
endmodule