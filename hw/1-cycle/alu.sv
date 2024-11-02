typedef bit[31:0] word_t;
typedef enum bit[4:0] { ALU_NOP, ALU_ADD, ALU_SUB, ALU_AND, ALU_OR, ALU_XOR,
                        ALU_SLL, ALU_SRL, ALU_SRA, ALU_SLT, ALU_SLTU } ALU_f;

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
                ALU_SLT : out = { {31{1'b0}}, $signed(src_a) < $signed(src_b) };
                ALU_SLTU: out = { {31{1'b0}}, src_a < src_b };
		ALU_SLL : out = src_a << src_b[4:0];
		ALU_SRL : out = src_a >> src_b[4:0];
		ALU_SRA : out = src_a >>> src_b[4:0];
                default : out = 'X;
	endcase
	end
endmodule
