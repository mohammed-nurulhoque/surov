/* verilator lint_off CASEINCOMPLETE */

module control (
    input logic clk,
    input logic rst,

    input opcode_t opcode,
    input logic done,

    output ctrl_t ctrl,
    output logic rf_wren,
    output logic mem_rden,
    output logic mem_wren
);
    logic[1:0] cycle;
    opcode_t current_opcode;
    logic start;

    logic[1:0] max_cycle;
    always_comb begin
        case (opcode)
            OP_OP:     max_cycle = 2;
            OP_IMM:    max_cycle = 1;
            OP_LOAD:   max_cycle = 2;
            OP_STORE:  max_cycle = 2;
            OP_BRANCH: max_cycle = 3;
            OP_JAL:    max_cycle = 1;
            OP_JALR:   max_cycle = 2;
            OP_AUIPC:  max_cycle = 1;
            OP_LUI:    max_cycle = 1;
            default:   max_cycle = 0; // should not happen
        endcase
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            cycle <= `CYCLE_INIT;
            current_opcode <= opcode_t'(`OP_INIT);
            start <= 1;
        end else begin
            if (done) begin
                cycle <= (cycle == max_cycle) ? 0: cycle + 1;
                start <= 1;
            end else begin
                start <= 0;
            end
            if (cycle == 0)
                current_opcode <= opcode;
        end
    end

    always_comb begin
        ctrl.opcode = current_opcode;
        ctrl.start = start;

    // update PC
        case (current_opcode)
            OP_OP, OP_JALR: ctrl.update_pc = cycle == 1;
            default: ctrl.update_pc = cycle == 0;
        endcase

    // update instruction
        case (current_opcode)
            OP_LOAD, OP_STORE: ctrl.update_instr = cycle == 1;
            default: ctrl.update_instr = cycle == max_cycle;
        endcase

    // read RF rs1, rs2
        ctrl.rf_rs1 = cycle == 0;
        ctrl.rf_rs2 = 0;
        case (current_opcode)
            OP_OP, OP_STORE: ctrl.rf_rs2 = cycle == 1;
            OP_BRANCH: begin
                ctrl.rf_rs1 = cycle == 1;
                ctrl.rf_rs2 = cycle == 0;
            end
            OP_JAL, OP_LUI, OP_AUIPC: ctrl.rf_rs1 = 0;
        endcase

        ctrl.save_rd = cycle == 0;
        ctrl.save_op = (current_opcode == OP_BRANCH && cycle == 1);

        case (current_opcode)
            OP_BRANCH, OP_JAL, OP_AUIPC: ctrl.save_pc = cycle == 0;
            default: ctrl.save_pc = 0;
        endcase

        ctrl.save_pc_next = (current_opcode == OP_JALR && cycle == 0);
        ctrl.save_br_target = (current_opcode == OP_BRANCH && cycle == 1);

        case (current_opcode)
            OP_LOAD: ctrl.memop = cycle == 1;
            OP_STORE: ctrl.memop = cycle == 2;
            default: ctrl.memop = 0;
        endcase

        case (cycle)
            0: case (current_opcode)
                OP_OP: ctrl.alu_ctrl = ALUC_NONE;
                OP_JAL: ctrl.alu_ctrl = ALUC_PC_IMM;
                default: ctrl.alu_ctrl = ALUC_PC_4;
            endcase
            1: case (current_opcode)
                OP_OP: ctrl.alu_ctrl = ALUC_PC_4;
                OP_IMM: ctrl.alu_ctrl = ALUC_OPEXE;
                OP_JAL: ctrl.alu_ctrl = ALUC_RS1_4;
                OP_LUI: ctrl.alu_ctrl = ALUC_NONE;
                default: ctrl.alu_ctrl = ALUC_RS1_IMM;
            endcase
            2: case (current_opcode)
                OP_OP: ctrl.alu_ctrl = ALUC_OPEXE;
                OP_BRANCH: ctrl.alu_ctrl = ALUC_BRANCH_OP;
                default: ctrl.alu_ctrl = ALUC_NONE;
            endcase
            3: ctrl.alu_ctrl = ALUC_NONE;
        endcase
    end

    // RF write enable
    always_comb begin
        case (current_opcode)
            OP_STORE, OP_BRANCH: rf_wren = 0;
            OP_LUI: rf_wren = cycle == 0;
            default: rf_wren = cycle == max_cycle;
        endcase
    end

    always_comb begin
        case (current_opcode)
            OP_BRANCH: mem_rden = cycle == 2;
            OP_LOAD: mem_rden = ctrl.update_pc || ctrl.memop;
            default: mem_rden = ctrl.update_pc;
        endcase
    end
    assign mem_wren = current_opcode == OP_STORE && cycle == 2;


endmodule