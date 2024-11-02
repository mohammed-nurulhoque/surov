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

    logic[WIDTH:0] adder_a, adder_b;
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
            ADDER_EQ: out = (adder_out[WIDTH:1] == 0);
            ADDER_NE: out = (adder_out[WIDTH:1] != 0);
            ADDER_LT, ADDER_LTU: out = adder_out[WIDTH];
            ADDER_GE, ADDER_GEU: out = ~(adder_out[WIDTH]);
            ADDER_ADD : out = adder_out[WIDTH:1];
            ADDER_SUB : out = adder_out[WIDTH:1];
            default : out = 'X;
        endcase
	end
endmodule

module shifter #(
    parameter int WIDTH=32,
    parameter int SBITS=3,
    parameter logic BIAS=0
) (
    input logic [WIDTH-1:0] val,
    input logic [SBITS-1:0] sham,
    input logic right_shift,
    input arith_shift,
    output logic [WIDTH-1:0] out
);
    wire [WIDTH-1:0] sel_in;
    assign sel_in = right_shift ? val : {<<{val}};
    wire [WIDTH-1:0] tmp_out = {{arith_shift ? val[WIDTH-1]: 1'b0}, sel_in} >> (sham+BIAS);
    assign out = right_shift ? tmp_out : {<<{tmp_out}};
endmodule
