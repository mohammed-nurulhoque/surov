/* verilator lint_off CASEINCOMPLETE */

module control (
    input logic clk,
    input logic rst,

    input opcode_t opcode,
    input logic done,

    output ctrl_t control,
    output logic rf_wren,
    output logic mem_rden,
    output logic mem_wren,

    output logic[1:0] cycle,
    output logic[1:0] max_cycle,
    output logic trap
);
    opcode_t current_opcode, saved_opcode;
    logic start;

    always_comb begin
        case (current_opcode)
            OP_OP:     max_cycle = 2;
            OP_IMM:    max_cycle = 1;
            OP_LOAD:   max_cycle = 2;
            OP_STORE:  max_cycle = 2;
            OP_BRANCH: max_cycle = 3;
            OP_JAL:    max_cycle = 1;
            OP_JALR:   max_cycle = 2;
            OP_AUIPC:  max_cycle = 1;
            OP_LUI:    max_cycle = 1;
            OP_FENCE:  max_cycle = 1;
            OP_SYS:    max_cycle = 1;
            default:   max_cycle = 0; // should not happen
        endcase
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            cycle <= `CYCLE_INIT;
            start <= 1;
        end else begin
            if (done) begin
                cycle <= (cycle == max_cycle) ? 0: cycle + 1;
                start <= 1;
            end else begin
                start <= 0;
            end
            if (cycle == 0)
                saved_opcode <= opcode;
        end
    end
    assign current_opcode = (cycle == 0) ? opcode : saved_opcode;
    assign trap = current_opcode == OP_SYS && cycle == 0;

    always_comb begin
        control.opcode = current_opcode;
        control.start = start;

    // update PC
        case (current_opcode)
            OP_OP, OP_JALR: control.update_pc = cycle == 1;
            OP_BRANCH: control.update_pc = (cycle == 0 || cycle == 2);
            default: control.update_pc = cycle == 0;
        endcase

    // update instruction
        case (current_opcode)
            OP_LOAD, OP_STORE: control.update_instr = cycle == 1;
            default: control.update_instr = (cycle == max_cycle) && done;
        endcase

    // read RF rs1, rs2
        control.rf_rs1 = cycle == 0;
        control.rf_rs2 = 0;
        case (current_opcode)
            OP_OP, OP_STORE: control.rf_rs2 = cycle == 1;
            OP_BRANCH: begin
                control.rf_rs1 = cycle == 1;
                control.rf_rs2 = cycle == 0;
            end
            OP_JAL, OP_LUI, OP_AUIPC, OP_SYS, OP_FENCE: control.rf_rs1 = 0;
        endcase

        control.save_rd = cycle == 0;
        control.save_f3 = (current_opcode == OP_BRANCH && cycle == 1);
        control.save_store_target = (current_opcode == OP_STORE && cycle == 1);

        case (current_opcode)
            OP_BRANCH, OP_JAL, OP_AUIPC: control.save_pc = cycle == 0;
            default: control.save_pc = 0;
        endcase

        control.save_pc_next = (current_opcode == OP_JALR && cycle == 0);
        control.save_br_target = (current_opcode == OP_BRANCH && cycle == 1);
        control.update_cntr_data = (current_opcode == OP_SYS && cycle == 0);

        case (current_opcode)
            OP_LOAD: control.memop = cycle == 1;
            OP_STORE: control.memop = cycle == 2;
            default: control.memop = 0;
        endcase

        case (cycle)
            0: case (current_opcode)
                OP_OP: control.alu_ctrl = ALUC_NONE;
                OP_JAL: control.alu_ctrl = ALUC_PC_IMM;
                default: control.alu_ctrl = ALUC_PC_4;
            endcase
            1: case (current_opcode)
                OP_OP: control.alu_ctrl = ALUC_PC_4;
                OP_IMM: control.alu_ctrl = ALUC_OPEXE;
                OP_JAL: control.alu_ctrl = ALUC_RS1_4;
                OP_LUI, OP_FENCE, OP_SYS: control.alu_ctrl = ALUC_NONE;
                default: control.alu_ctrl = ALUC_RS1_IMM;
            endcase
            2: case (current_opcode)
                OP_OP: control.alu_ctrl = ALUC_OPEXE;
                OP_BRANCH: control.alu_ctrl = ALUC_BRANCH_OP;
                default: control.alu_ctrl = ALUC_NONE;
            endcase
            3: control.alu_ctrl = ALUC_NONE;
        endcase
    end

    // RF write enable
    always_comb begin
        case (current_opcode)
            OP_STORE, OP_BRANCH, OP_FENCE: rf_wren = 0;
            OP_LUI: rf_wren = cycle == 0;
            default: rf_wren = cycle == max_cycle;
        endcase
    end

    always_comb begin
        case (current_opcode)
            OP_BRANCH: mem_rden = cycle == 2;
            OP_LOAD: mem_rden = control.update_pc || control.memop;
            default: mem_rden = control.update_pc;
        endcase
    end
    assign mem_wren = current_opcode == OP_STORE && cycle == 2;

endmodule