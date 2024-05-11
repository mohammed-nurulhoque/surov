`include "common/defs.sv"
`include "common/alu.sv"
module Top(
    input logic clk, rst,
    // instruction memory
    output word_t pc,
    input word_t inst,
    // data memory
    output logic dmem_rd,
    output logic dmem_wr,
    output word_t dmem_addr,
    output mem_addr_t dmem_size,
    input word_t dmem_data_in,
    output word_t dmem_data_out
);
    word_t regfile[31:0];

    opcode_t op;
    regnum_t rs1, rs2, rd;
    word_t rs1val, rs2val, rdval;
    assign op = ext_opcode(inst);
    assign rd = ext_rd(inst);
    assign rs1 = ext_rs1(inst);
    assign rs2 = ext_rs2(inst);

    assign rs1val = regfile[rs1];
    assign rs2val = regfile[rs2];
    assign dmem_rd = (op == OP_LOAD);

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
                default : alu_f = 'X;
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
                default   : alu_f = 'X;
            endcase
            default: alu_f = 'X;
        endcase
    end

    word_t src_a, src_b;
    always_comb begin
    case (op)
        OP_OP, OP_IMM, OP_LOAD, OP_STORE, OP_BRANCH, OP_JALR:
            src_a = rs1val;
        OP_AUIPC, OP_JAL:
            src_a = pc;
        default:
            src_a = 'X;
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
        default:
            src_b = 'X;
    endcase
    end

    word_t alu_out;
    ALU alu(alu_f, src_a, src_b, alu_out);

    assign dmem_wr = (op == OP_STORE);
    assign dmem_data_out = ((dmem_wr) ? rs2val : 32'bz);
    assign dmem_addr = alu_out;

    // write back
    logic wr_reg;
    always_comb begin
        case (op)
            OP_OP, OP_IMM, OP_AUIPC: begin
                rdval = alu_out;
                wr_reg = 1;
            end
            OP_LOAD: begin
                rdval = dmem_data_in;
                wr_reg = 1;
            end
            OP_LUI: begin
                rdval = ext_u_imm(inst);
                wr_reg = 1;
            end
            OP_JAL, OP_JALR: begin
                rdval = pc + 4;
                wr_reg = 1;
            end
            default: begin
                rdval = 'X;
                wr_reg = 0;
            end
        endcase
    end
    always_ff @(posedge clk) begin
        if (rd != 0 && wr_reg) begin
            regfile[rd] = rdval;
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
            default:       branch_pred = 'X;
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
