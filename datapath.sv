`include "defs.sv"

module datapath(
	input logic clk, rst, kill_d, stall_f, stall_d, branch_taken, wr_en
);
	word_t pcFromF, pcFromD, pcFromM;
	word_t instrFromF, instrFromD, instrFromM;
	word_t src_aFromD, src_bFromD;
	word_t branch_target, wr_data;

	Fetch F(.clk, .rst, .stall_f, .branch_taken, .branch_target,
	        .pc_out(pcFromF), .instr_out(instrFromF));
	
	// wires routing between register file and decode
	word_t src_a, src_b;
	decode D(.clk, .rst(rst || kill_d), .stall_d, 
	         .pc_in(pcFromF), .instr_in(instrFromF),
	         .src_a_in(src_a), .src_b_in(src_b),
	         .pc_out(pcFromD), .instr_out(instrFromD),
	         .src_a_out(src_aFromD), .src_b_out(src_bFromD));
	regfile RF(.clk, .rs1(ext_rs1(instrFromF)), .rs2(ext_rs2(instrFromF)), .rd(ext_rd(.instr(instrFromM))), .wr_en, .wr_data,
	           .data_1(src_a), .data_2(src_b));
endmodule

module Fetch(
	input logic   clk,
	input logic   rst,
	input logic   stall_f,
	input logic   branch_taken,
	input word_t  branch_target,
	output word_t pc_out,
	output word_t instr_out
);
	word_t imem[256:0];
	initial begin
		$readmemh("imem", imem);
	end

	word_t pc;
	always_comb
		if (rst) begin
			pc = 0;
		end else if (!stall_f) begin
			if (branch_taken)
				pc = branch_target;
			else
				pc = pc_out+4;
		end

	always_ff@(posedge clk) begin
		instr_out <= imem[pc >> 2];
		pc_out <= pc;
	end
endmodule

module regfile(
		input logic clk,
		input regnum_t rs1,
		input regnum_t rs2,
		input regnum_t rd,
		input logic wr_en,
		input word_t wr_data,
		output word_t data_1,
		output word_t data_2
);
	word_t rf[31:0];
	always_ff@(posedge clk) begin
		data_1 = rf[rs1];
		data_2 = rf[rs2];
		if (wr_en && rd != 0)
			rf[rd] <= wr_data;
	end
endmodule

module decode(
	input logic     clk, rst, stall_d,
	input word_t    pc_in, instr_in,
	input word_t    src_a_in, src_b_in,
	output word_t   pc_out, instr_out,
	output word_t   src_a_out, src_b_out
);
	
	assign rs1 = instr_in[19:15];
	assign rs2 = instr_in[24:20];
	
	always_ff@(posedge clk)
		if (rst) begin
			pc_out    <= 0;
			instr_out <= NOP;
		end else if (!stall_d) begin
			pc_out    <= pc_in;
			instr_out <=  instr_in;
			src_a_out <= src_a_in;
			src_b_out <= src_b_in;
		end
endmodule

module alu(
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
	opcode_t op;
	ext_opcode(instr_in, op);
	logic is_arith;
	isSR_arith(instr_in, is_arith);

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
	ALU(alu_f, src_a_in, src_a_out, alu_out);
endmodule