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
		ALU_SLT : out = $signed(src_a) < $signed(src_b);
		ALU_SLTU: out = src_a < src_b;
		ALU_SLL : out = src_a << src_b;
		ALU_SRL : out = src_a >> src_b;
		ALU_SRA : out = src_a >>> src_b;
	endcase
	end
endmodule

module Execute(
	input logic clk, rst, stall_e,
	input word_t    pc_in, instr_in,
	input word_t    src_a_in, src_b_in,
	output word_t   pc_out, instr_out, data
);
	opcode_t op = ext_opcode(instr_in);
	logic is_arith = isSR_arith(instr_in);

	ALU_f alu_f;
	// compute ALU function
	always_comb begin
		case (op)
		OP_LOAD, OP_STORE : alu_f = ALU_ADD;
		OP_AUIPC, OP_LUI, OP_JALR, OP_JAL : alu_f = ALU_NOP;
		OP_BRANCH: alu_f = ALU_SUB;
		OP_IMM: case (ext_f3(instr_in))
					OPIMM_ADDI  : alu_f = ALU_ADD;
    				OPIMM_SLTI  : alu_f = ALU_SLT;
    				OPIMM_SLTIU : alu_f = ALU_SLTU;
    				OPIMM_XORI  : alu_f = ALU_XOR;
    				OPIMM_ORI   : alu_f = ALU_OR;
    				OPIMM_ANDI  : alu_f = ALU_AND;
    				OPIMM_SLLI  : alu_f = ALU_SLL;
    				OPIMM_SRI   : alu_f = is_arith ? ALU_SRA : ALU_SRL; 
				endcase
		endcase
	end
	word_t alu_out;
	ALU alu(alu_f, src_a_in, src_a_out, alu_out);
endmodule
