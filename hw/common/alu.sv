module ALU(
	input ALU_f func,
	input word_t src_a,
	input word_t src_b,
	output word_t out
);
	always_comb begin
	case (func)
		ALU_ADD : out = src_a + src_b;
		ALU_SUB : out = src_a - src_b;
		ALU_AND : out = src_a & src_b;
		ALU_OR  : out = src_a | src_b;
		ALU_XOR : out = src_a ^ src_b;
                ALU_SLT, ALU_SLTU : begin
                    logic s1msb = func == ALU_SLT ? src_a[31]: 0;
                    logic s2msb = func == ALU_SLT ? src_b[31]: 0;
                    logic[32:0] s1 = {s1msb, src_a};
                    logic[32:0] s2 = {s2msb, src_b};
                    out = { {31{1'b0}}, $signed(s1) < $signed(s2) };
                end
		ALU_SLL : out = src_a << src_b[4:0];
		ALU_SRL : out = src_a >> src_b[4:0];
		ALU_SRA : out = src_a >>> src_b[4:0];
	endcase
	end
endmodule
