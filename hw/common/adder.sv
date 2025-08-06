module adder #(localparam int WIDTH = 32)
(
    input adderOp_t op,
    input logic signed[WIDTH-1:0] src_a,
    input logic signed[WIDTH-1:0] src_b,
    // input logic cin,
    output logic[WIDTH-1:0] out,
    output logic cout
);

    logic is_sub, is_signed_sub;
    always_comb begin
        unique case (op)
            ADDER_ADD: begin
                is_sub = 1'b0;
                is_signed_sub = 1'b0;
            end
            ADDER_LT, ADDER_GE: begin
                is_sub = 1'b1;
                is_signed_sub = 1'b1;
            end
            ADDER_SUB, ADDER_LTU, ADDER_GEU: begin
                is_sub = 1'b1;
                is_signed_sub = 1'b0;
            end
            default: begin
                is_sub = 1'bX;
                is_signed_sub = 1'bX;
            end
        endcase
    end

    logic[WIDTH+1:0] adder_a, adder_b;
    wire signed[WIDTH-1:0] b_tmp = is_sub ? ~src_b : src_b;

    always_comb begin
        adder_a = {(WIDTH+1)'(src_a), 1'b1};
        adder_b = {(WIDTH+1)'(b_tmp), is_sub}; // cin
        if (!is_signed_sub) begin
            adder_a[WIDTH+1] = 1'b0;
            adder_b[WIDTH+1] = 1'b1;
        end
    end

    wire logic[WIDTH+1:0] adder_out = adder_a + adder_b;
    assign cout = adder_out[WIDTH+1];

    wire logic eq = src_a == src_b;

	always_comb begin
        unique case (adderOp_t'(op))
            ADDER_EQ: out = {31'b0, eq};
            ADDER_NE: out = {31'b0, ~eq};
            ADDER_LT, ADDER_LTU: out = {31'b0, adder_out[WIDTH+1]};
            ADDER_GE, ADDER_GEU: out = {31'b0, ~(adder_out[WIDTH+1])};
            ADDER_ADD : out = adder_out[WIDTH:1];
            ADDER_SUB : out = adder_out[WIDTH:1];
            default : out = 'X;
        endcase
	end
endmodule
