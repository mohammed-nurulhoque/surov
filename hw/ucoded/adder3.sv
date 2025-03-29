
typedef enum bit[2:0] {
    ADDER_ADD = 3'b010,
    ADDER_SUB = 3'b011,

    ADDER_EQ  = 3'b000,
    ADDER_NE  = 3'b001,
    ADDER_LT  = 3'b100,
    ADDER_GE  = 3'b101,
    ADDER_LTU = 3'b110,
    ADDER_GEU = 3'b111
} adderOp_t;

module uadder #(
    parameter int WIDTH = 32,
    parameter int WADD = 12,
    localparam int NCYC = (WIDTH + WADD - 1) / WADD,
    localparam int WCYC = $clog2(NCYC)
) (
    input logic clk,
    input logic rst,
    input logic start,

    input adderOp_t op,
    input logic signed[WIDTH-1:0] src_a,
    input logic signed[WIDTH-1:0] src_b,

    output logic[WIDTH-1:0] out,
    output logic cout,
);
    // state registers
    logic[WCYC-1:0] cycle;
    logic cin;

    wire is_sub = op != ADDER_ADD;
    wire is_signed_sub = (op == ADDER_LT | op == ADDER_GE);

    always_ff @(posedge clk) begin
        if (rst) cycle <= 0;
        else if (cycle == NCYC-1) cycle <= 0;
        else if (start) cycle <= cycle + 1;
    end
    
    wire [WADD:0] adder_a, adder_b;
    wire [WADD+1:0] adder_out;

    assign adder_a = src_a[cycle*WADD +: WADD];
    assign adder_b = src_b[cycle*WADD +: WADD];

    


endmodule