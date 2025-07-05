module adder #(parameter int WIDTH = 32)
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
            adder_b = {1'b1, b_tmp, is_sub}; // cin
        end
    end
    wire logic[WIDTH+1:0] adder_out = adder_a + adder_b;
    assign cout = adder_out[WIDTH+1];

    wire logic or_out = |adder_out;

	always_comb begin
        unique case (adderOp_t'(op))
            ADDER_EQ: out = {31'b0, ~or_out};
            ADDER_NE: out = {31'b0, or_out};
            ADDER_LT, ADDER_LTU: out = {31'b0, adder_out[WIDTH+1]};
            ADDER_GE, ADDER_GEU: out = {31'b0, ~(adder_out[WIDTH+1])};
            ADDER_ADD : out = adder_out[WIDTH:1];
            ADDER_SUB : out = adder_out[WIDTH:1];
            default : out = 'X;
        endcase
	end
endmodule
