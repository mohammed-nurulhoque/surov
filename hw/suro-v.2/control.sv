/* verilator lint_off CASEINCOMPLETE */

module control (
    input logic clk,
    input logic rst,

    input opcode_t opcode,
    input logic done,
    input logic branch_taken,

    output ctrl_t ctrl,
    output logic rf_wren,
    output logic mem_rden,
    output logic mem_wren,

    output logic[1:0] cycle,
    output logic trap
);
    logic start;
    logic rst_latch;

    always_ff @(posedge clk) begin
        if (rst) begin
            cycle <= 1;
            start <= 1;
            rst_latch <= 1;
        end else begin
            rst_latch <= 0;
            if (done) begin
                start <= 1;
                unique case (cycle)
                    0: begin
                        unique case (opcode)
                            OP_OP, OP_LOAD, OP_STORE, OP_BRANCH, OP_JALR: cycle <= 1;
                            default: cycle <= 2;
                        endcase
                    end
                    1: begin
                        unique case (opcode)
                            OP_STORE: cycle <= 0;
                            default: cycle <= 2;
                        endcase
                    end
                    2: begin
                        unique case (opcode)
                            OP_LOAD: cycle <= 3;
                            OP_BRANCH: cycle <= branch_taken ? 3 : 0;
                            default: cycle <= 0;
                        endcase
                    end
                    3: cycle <= 0;
                endcase
            end else begin
                start <= 0;
            end
        end
    end
    assign trap = opcode == OP_SYS && cycle == 0;

    always_comb begin
        ctrl.start = start;
        unique case (cycle)
            0: begin
                ctrl.set_r1 = 1;
                ctrl.r1_src = SRC_RF;
                ctrl.set_r2 = 0;
                ctrl.r2_src = 'x;
                ctrl.set_pc = 1;
                ctrl.pc_src = (opcode == OP_JAL) ? SRC_ALU : SRC_PC_PLUS4;
                ctrl.set_pc2 = 0;
                ctrl.set_ir = 0;
                unique case (opcode)
                    OP_JAL:   ctrl.rf_src = SRC_PC_PLUS4;
                    OP_AUIPC: ctrl.rf_src = SRC_ALU;
                    OP_SYS:   ctrl.rf_src = SRC_CNTR;
                    default:  ctrl.rf_src = src_t'({ $bits(src_t){1'bx} }); // default (explicit enum-sized X)
                endcase
                unique case (opcode)
                    OP_JAL, OP_AUIPC, OP_SYS:   ctrl.rf_regnum_src = RD;
                    OP_LUI:   ctrl.rf_regnum_src = X0;
                    default:  ctrl.rf_regnum_src = RS1; // default. FIXME set 'x for non-rf?
                endcase
                unique case (opcode)
                    OP_JAL: ctrl.maddr_src = SRC_ALU;
                    OP_LOAD, OP_JALR: ctrl.maddr_src = src_t'({ $bits(src_t){1'bx} });
                    default: ctrl.maddr_src = SRC_PC_PLUS4;
                endcase
                ctrl.memop = 0;
                if (opcode == OP_JAL || opcode == OP_AUIPC) begin
                    ctrl.alu_a_r1 = 0;
                    ctrl.alu_b_r2 = 0;
                    ctrl.alu_op = 0;
                end else begin
                    ctrl.alu_a_r1 = 'x;
                    ctrl.alu_b_r2 = 'x;
                    ctrl.alu_op = 'x;
                end
            end
            1: begin
                ctrl.set_r1 = 0; // if we forward rs2 from store to next instr, this needs to be set
                ctrl.r1_src = src_t'({ $bits(src_t){1'bx} });
                ctrl.set_r2 = 1;
                ctrl.r2_src = 1; // RF read
                ctrl.set_pc = 0;
                ctrl.pc_src = src_t'({ $bits(src_t){1'bx} });
                ctrl.set_pc2 = (opcode == OP_BRANCH || opcode == OP_JALR);
                ctrl.set_ir = opcode == OP_STORE;
                ctrl.rf_src = SRC_ALU;
                unique case (opcode)
                    OP_JALR, OP_LOAD: ctrl.rf_regnum_src = X0;
                    OP_OP, OP_STORE, OP_BRANCH:       ctrl.rf_regnum_src = RS2;
                    default: ctrl.rf_regnum_src = regnum_src_t'({ $bits(regnum_src_t){1'bx} });
                endcase
                ctrl.maddr_src = SRC_ALU;
                ctrl.memop = (opcode == OP_STORE || opcode == OP_LOAD);
                unique case (opcode)
                    OP_BRANCH:                  ctrl.alu_a_r1 = 0;
                    OP_JALR, OP_LOAD, OP_STORE: ctrl.alu_a_r1 = 1;
                    default:                    ctrl.alu_a_r1 = 'x;
                endcase
                ctrl.alu_b_r2 = rst_latch;
                ctrl.alu_op = 0;
            end
            2: begin
                ctrl.set_r1 = 1;        // when forwarding, AUIPC should not set r1
                unique case (opcode)
                    OP_LOAD:   ctrl.r1_src = SRC_MEM;
                    OP_OP, OP_IMM: ctrl.r1_src = SRC_ALU;
                    default:   ctrl.r1_src = src_t'({ $bits(src_t){1'bx} });  // forwarding will need to handle this
                endcase
                ctrl.set_r2 = 1; // only for shift. datapath uses r2_src to decide.
                ctrl.r2_src = 0; // shamt_out
                ctrl.set_pc = ((opcode == OP_BRANCH && branch_taken) || opcode == OP_JALR);
                ctrl.pc_src = SRC_PC2;
                ctrl.set_pc2 = 0;
                ctrl.set_ir = !(opcode == OP_LOAD || (opcode == OP_BRANCH && branch_taken));
                ctrl.rf_src = SRC_ALU;
                ctrl.rf_regnum_src = RD;
                unique case (opcode)
                    OP_LOAD:   ctrl.maddr_src = SRC_ALU;
                    OP_BRANCH: ctrl.maddr_src = SRC_PC2;
                    default:   ctrl.maddr_src = src_t'({ $bits(src_t){1'bx} });
                endcase
                ctrl.memop = 0;
                unique case (opcode)
                    OP_IMM:    begin
                        ctrl.alu_a_r1 = 1;
                        ctrl.alu_b_r2 = !start; // 1st cycle use immediate, subsequently use r2 (shifts)
                        ctrl.alu_op = 1;
                    end
                    OP_OP, OP_BRANCH: begin
                        ctrl.alu_a_r1 = 1;
                        ctrl.alu_b_r2 = 1;
                        ctrl.alu_op = 1;
                    end
                    OP_LUI: begin
                        ctrl.alu_a_r1 = 1;
                        ctrl.alu_b_r2 = 0;
                        ctrl.alu_op = 0;
                    end
                    OP_LOAD, OP_JALR: begin
                        ctrl.alu_a_r1 = 0;
                        ctrl.alu_b_r2 = 1;
                        ctrl.alu_op = 0;
                    end
                    default: begin
                        ctrl.alu_a_r1 = 'x;
                        ctrl.alu_b_r2 = 'x;
                        ctrl.alu_op = 'x;
                    end
                endcase
            end
            3: begin
                ctrl.set_r1 = 0;
                ctrl.r1_src = src_t'({ $bits(src_t){1'bx} });
                ctrl.set_r2 = 0;
                ctrl.r2_src = 'x;
                ctrl.set_pc = 0;
                ctrl.pc_src = src_t'({ $bits(src_t){1'bx} });
                ctrl.set_pc2 = 0;
                ctrl.set_ir = 1;
                ctrl.rf_src = SRC_ALU;
                ctrl.rf_regnum_src = RD;
                ctrl.maddr_src = src_t'({ $bits(src_t){1'bx} });
                ctrl.memop = 0;
                ctrl.alu_a_r1 = (opcode == OP_LOAD) ? 1 : 'X;
                ctrl.alu_b_r2 = (opcode == OP_LOAD) ? 1 : 'X;;
                ctrl.alu_op = 0;
            end
        endcase
        if (rst) begin
            ctrl.set_r1 = 1;
            ctrl.r1_src = SRC_MEM;
            ctrl.set_r2 = 1;
            ctrl.rf_regnum_src = X0;
        end
    end

    // RF write enable
    always_comb begin
        unique case (opcode)
            OP_STORE, OP_BRANCH, OP_FENCE: rf_wren = 0;
            OP_JAL, OP_AUIPC, OP_SYS: rf_wren = cycle == 0;
            OP_LOAD: rf_wren = cycle == 3;
            default: rf_wren = cycle == 2;
        endcase
    end

    always_comb begin
        unique case (opcode)
            OP_JALR: mem_rden = cycle == 1;
            OP_LOAD: mem_rden = ((cycle == 1) || (cycle == 2));
            default: mem_rden = ctrl.set_pc;
        endcase
        if (rst) mem_rden = 0;
    end
    assign mem_wren = (!rst) && (opcode == OP_STORE) && (cycle == 1);

endmodule