`include "common/defs.sv"
`include "common/alu.sv"
module Top(
    input logic clk, rst
);
    word_t pc;
    word_t dmem[255:0];
    word_t imem[63:0];
    word_t regfile[31:0];

    word_t inst = imem[pc];
    opcode_t op  = ext_opcode(inst);
    regnum_t rd  = ext_rd(inst);
    regnum_t rs1 = ext_rs1(inst);
    regnum_t rs2 = ext_rs2(inst);

    word_t rs1val = regfile[rs1];
    word_t rs2val = regfile[rs2];

	// compute ALU function
    ALU_f alu_f;
	always_comb begin
		case (op)
		OP_LOAD, OP_STORE, OP_JALR : alu_f = ALU_ADD;
		OP_AUIPC, OP_LUI, OP_JAL : alu_f = ALU_NOP;
		OP_BRANCH: 
            case (branch_t'(ext_f3(inst)))
                BR_EQ, BR_NE:   alu_f = ALU_SUB;
                BR_LT, BR_GE:   alu_f = ALU_SLT;
                BR_LTU, BR_GEU: alu_f = ALU_SLTU;
            endcase
		OP_IMM, OP_OP:
			case (opFunc_t'(ext_f3(inst)))
				FUNC_ADD  : alu_f = (op == OP_OP && isSubtract(inst)) ? 
								  ALU_SUB :
								  ALU_ADD;
				FUNC_SLT  : alu_f = ALU_SUB;
				FUNC_SLTU : alu_f = ALU_SUB;
				FUNC_XOR  : alu_f = ALU_XOR;
				FUNC_OR   : alu_f = ALU_OR;
				FUNC_AND  : alu_f = ALU_AND;
				FUNC_SLL  : alu_f = ALU_SLL;
				FUNC_SR   : alu_f = isAShift(inst) ? ALU_SRA : ALU_SRL; 
			endcase
		endcase
	end

    word_t src_a, src_b;
    always_comb begin
    case (op)
        OP_OP, OP_IMM, OP_LOAD, OP_STORE, OP_BRANCH, OP_JALR:
            src_a = rs1val;
        OP_AUIPC, OP_JAL:
            src_a = pc;
    endcase
    end

    always_comb begin
    case (op)
        OP_OP, OP_BRANCH:
            src_b = rs2val;
        OP_AUIPC:
            src_b = ext_u_imm(inst);
        OP_LOAD, OP_IMM, OP_JALR:
            src_b = ext_i_imm(inst);
        OP_STORE:
            src_b = ext_s_imm(inst);
        OP_JAL:
            src_b = ext_j_imm(inst);
    endcase
    end

	word_t alu_out;
	ALU alu(alu_f, src_a, src_b, alu_out);

    // write back
    always_ff @(posedge clk) begin
        if (rd != 0) begin
            case (op)
                OP_OP, OP_IMM, OP_AUIPC:
                    regfile[rd] = alu_out;
                OP_LOAD:
                    regfile[rd] = dmem[alu_out[7:0]];
                OP_LUI:
                    regfile[rd] = ext_u_imm(inst);
                OP_JAL, OP_JALR:
                    regfile[rd] = pc + 4;
            endcase
        end
        if (op == OP_STORE) begin
            dmem[alu_out[7:0]] = rs2val;
        end
    end

    // compute branch cond
    logic branch_pred;
    always_comb begin
        case (branch_t'(ext_f3(inst)))
            BR_EQ:         branch_pred = alu_out == 0;
            BR_NE:         branch_pred = alu_out != 0;
            BR_LT, BR_LTU: branch_pred = alu_out[0];
            BR_GE, BR_GEU: branch_pred = !(alu_out[0]);
        endcase
    end

    // update pc
    always_ff @(posedge clk) begin
		if (rst) begin
			pc = 0;
        end else begin
            case (op)
                OP_JAL, OP_JALR:
                    pc = alu_out;
                OP_BRANCH:
                    pc = branch_pred? pc + ext_b_imm(inst) : pc + 4;
                default:
                    pc = pc + 4;
            endcase
        end
    end
endmodule