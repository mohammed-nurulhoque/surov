module rf #(
    parameter WORD_SIZE = 32,
    parameter REG_COUNT = 32
)(
    input  wire                      clk,
    input  wire                      we,       // Write enable
    input  wire [$clog2(REG_COUNT)-1:0] addr,   // Address for both read and write
    input  wire [WORD_SIZE-1:0]     wdata,    // Data to write
    output reg [WORD_SIZE-1:0]     rdata     // Data to read
);

    reg [WORD_SIZE - 1 : 0] mem [REG_COUNT - 1 : 0];
    always @(posedge clk)
            if (we)
                    mem[addr] <= wdata;
    assign rdata = mem[addr];

endmodule