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
	input logic 	clk, rst, stall_e,
	input word_t    pc_in, instr_in,
	input word_t 	pc_offset,
	input word_t    src_a, src_b,
	output word_t   pc_out, instr_out, data, store_val
);
	opcode_t op = ext_opcode(instr_in);

	ALU_f alu_f;
	// compute ALU function
	always_comb begin
		case (op)
		OP_LOAD, OP_STORE, OP_JALR : alu_f = ALU_ADD;
		OP_AUIPC, OP_LUI, OP_JAL : alu_f = ALU_NOP;
		OP_BRANCH: alu_f = ALU_SUB;
		OP_IMM, OP_OP:
			case (ext_immf3(instr_in))
				FUNC_ADD  : alu_f = (op == OP_OP && isSubtract(instr_in)) ? 
								  ALU_SUB :
								  ALU_ADD;
				FUNC_SLT  : alu_f = ALU_SUB;
				FUNC_SLTU : alu_f = ALU_SUB;
				FUNC_XOR  : alu_f = ALU_XOR;
				FUNC_OR   : alu_f = ALU_OR;
				FUNC_AND  : alu_f = ALU_AND;
				FUNC_SLL  : alu_f = ALU_SLL;
				FUNC_SR   : alu_f = isAShift(instr_in) ? ALU_SRA : ALU_SRL; 
			endcase
		endcase
	end
	word_t alu_out;
	ALU alu(alu_f, src_a, src_b, alu_out);

	always_ff@(posedge clk) begin
		pc_out 		<= pc_in;
		instr_out 	<= instr_in;
		case (op)

	end
endmodule
