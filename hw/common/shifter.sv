module shifter #(
    parameter int WIDTH=32
) (
    input logic [WIDTH-1:0] val,
    input logic [$clog2(WIDTH)-1:0] sham,
    input logic right_shift,
    input logic arith_shift,
    output logic [WIDTH-1:0] out
);
    wire[WIDTH-1:0] reverse = {<<{val}}; 
    wire signed [WIDTH:0] sel_in = {{arith_shift ? val[WIDTH-1]: 1'b0},
                                  {right_shift ? val : reverse}};
    wire [WIDTH-1:0] tmp_out = WIDTH'(sel_in >>> sham);
    assign out = right_shift ? tmp_out : {<<{tmp_out}};
endmodule
