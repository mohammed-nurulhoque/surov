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

    // Register array
    reg [WORD_SIZE-1:0] regfile [0:REG_COUNT-1] /*verilator public*/;


    wire [REG_COUNT-1:0] addr_1hot;
    assign addr_1hot = 1'b1 << addr;
    always_comb begin
        rdata = {WORD_SIZE{1'b0}};
        for (int i = 1; i < REG_COUNT; i++) begin
            rdata |= {WORD_SIZE{addr_1hot[i]}} & regfile[i];
        end
    end

    // Synchronous write
    always_ff @(posedge clk) begin
        if (we)
            regfile[addr] <= wdata;
    end

endmodule