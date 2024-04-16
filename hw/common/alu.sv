module ALU(
	input ALU_f func,
	input word_t src_a,
	input word_t src_b,
	output word_t out
);
	always_comb begin
	case (func)
		ALU_ADD : out = src_a + src_b;
		ALU_SUB : out = src_b - src_a;
		ALU_AND : out = src_a & src_b;
		ALU_OR  : out = src_a | src_b;
		ALU_XOR : out = src_a ^ src_b;
		ALU_SLT : out = { {31{1'b0}}, $signed(src_a) < $signed(src_b) };
		ALU_SLTU: out = { {31{1'b0}}, src_a < src_b };
		ALU_SLL : out = src_a << src_b;
		ALU_SRL : out = src_a >> src_b;
		ALU_SRA : out = src_a >>> src_b;
	endcase
	end
endmodule