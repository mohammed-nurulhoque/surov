module ALU #(parameter int Width = 12)
(
    input aluOp_t op,
    input logic signed[Width-1:0] src_a,
    input logic signed[Width-1:0] src_b,
    input logic cin,
    output logic[Width-1:0] out,
    output logic cout
);
    wire is_sub = op != ALU_ADD;
    logic is_signed_sub;
    always_comb begin
        case (aluOp_t'(op))
            ALU_LT, ALU_GE: is_signed_sub = 1;
            default: is_signed_sub = 0;
        endcase
    end

    logic[Width:0] adder_a, adder_b;
    wire signed[Width-1:0] b_tmp = is_sub ? ~src_b : src_b;

    always_comb begin
        if (is_signed_sub) begin
            adder_a = {(Width+1)'(src_a), 1'b1};
            adder_b = {(Width+1)'(b_tmp), cin};
        end else begin
            adder_a = {1'b0, src_a, 1'b1};
            adder_b = {1'b0, b_tmp, is_sub};
        end
    end
    wire logic[Width+1:0] adder_out = adder_a + adder_b;
    assign cout = adder_out[Width+1];

	always_comb begin
        unique case (aluOp_t'(op))
            ALU_EQ: out = (adder_out == 0);
            ALU_NE: out = (adder_out != 0);
            ALU_LT, ALU_LTU: out = adder_out[Width];
            ALU_GE, ALU_GEU: out = ~(adder_out[Width]);
            ALU_ADD : out = adder_out[Width:1];
            ALU_SUB : out = adder_out[Width:1];
            default : out = 'X;
        endcase
	end
endmodule
