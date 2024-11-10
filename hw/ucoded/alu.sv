module adder #(parameter int WIDTH = 12)
(
    input adderOp_t op,
    input logic signed[WIDTH-1:0] src_a,
    input logic signed[WIDTH-1:0] src_b,
    // input logic cin,
    output logic[WIDTH-1:0] out,
    output logic cout
);
    wire is_sub = op != ADDER_ADD;
    wire is_signed_sub = (op == ADDER_LT | op == ADDER_GE);

    logic[WIDTH+1:0] adder_a, adder_b;
    wire signed[WIDTH-1:0] b_tmp = is_sub ? ~src_b : src_b;

    always_comb begin
        if (is_signed_sub) begin
            adder_a = {(WIDTH+1)'(src_a), 1'b1};
            adder_b = {(WIDTH+1)'(b_tmp), is_sub}; // cin
        end else begin
            adder_a = {1'b0, src_a, 1'b1};
            adder_b = {1'b0, b_tmp, is_sub}; // cin
        end
    end
    wire logic[WIDTH+1:0] adder_out = adder_a + adder_b;
    assign cout = adder_out[WIDTH+1];

	always_comb begin
        unique case (adderOp_t'(op))
            ADDER_EQ: out = {31'b0, (adder_out[WIDTH:1] == 0)};
            ADDER_NE: out = {31'b0, (adder_out[WIDTH:1] != 0)};
            ADDER_LT, ADDER_LTU: out = {31'b0, adder_out[WIDTH]};
            ADDER_GE, ADDER_GEU: out = {31'b0, ~(adder_out[WIDTH])};
            ADDER_ADD : out = adder_out[WIDTH:1];
            ADDER_SUB : out = adder_out[WIDTH:1];
            default : out = 'X;
        endcase
	end
endmodule

module shifter #(
    parameter int WIDTH=32
) (
    input logic [WIDTH-1:0] val,
    input logic [$clog2(WIDTH)-1:0] sham,
    input logic right_shift,
    input logic arith_shift,
    output logic [WIDTH-1:0] out
);
    wire signed [WIDTH:0] sel_in = {{arith_shift ? val[WIDTH-1]: 1'b0},
                                  {right_shift ? val : {<<{val}}}};
    wire [WIDTH-1:0] tmp_out = {sel_in >>> sham}[WIDTH-1:0];
    assign out = right_shift ? tmp_out : {<<{tmp_out}};
endmodule
