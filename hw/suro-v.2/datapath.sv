module datapath (
    input logic clk,
    input logic rst,

    input ctrl_t ctrl,
    output logic done,

    output opcode_t opcode,

    output regnum_t  regnum,
    input  word_t rfread_data,
    output word_t rfwrite_data,

    output cntr_t cntr_addr,
    input word_t cntr_data,

    output word_t  mem_addr,
    output mem_addr_t mem_size,
    input  word_t memread_data,
    output word_t memwrite_data
);
    dp_regs_t r /*verilator public*/;
    // update state registers
    always_ff @(posedge clk) begin
        // reset
        if (rst) begin
            r.pc       <= memread_data[31:0];
            r._1.inst  <= `INST_INIT;
        end else begin
            if (ctrl.update_pc) begin
                if (ctrl.alu_ctrl == ALUC_BRANCH_OP) begin
                    if (alu_out != 0)
                        r.pc <= r._1.branch_target[31:0]; // branch target
                end
                else 
                    r.pc <= alu_out[31:0];
            end
            
            if (ctrl.save_br_target)
                r._1.branch_target <= alu_out;
            else if (ctrl.update_instr)
                r._1.inst <= memread_data;
        end

        if (ctrl.rf_rs1)
            r._2.r1 <= rfread_data;
        else if (ctrl.alu_ctrl == ALUC_OPEXE)
            r._2.r1 <= alu_out;
        else if (ctrl.save_store_target)
            r._2.store_address <= alu_out;
        else if (ctrl.save_pc)
            r._2.saved_pc <= {r.pc};


        if (ctrl.rf_rs2)
            r._3.r2 <= rfread_data;
        else if (ctrl.alu_ctrl == ALUC_OPEXE && (ext_f3(r._1.inst) == FUNC_SLL || ext_f3(r._1.inst) == FUNC_SR))
            r._3.r2 <= word_t'(alu_shamt_out);
        else if (ctrl.save_pc_next)
            r._3.saved_pc_next <= alu_out;
        else if (ctrl.update_cntr_data)
            r._3.cntr_data <= cntr_data;
        

        if (ctrl.save_rd)
            r._4.rd <= regnum_t'(ext_rd(r._1.inst));
        else if (ctrl.save_f3)
            r._4.brf3 <= branch_t'(ext_f3(r._1.inst));
        else if (ctrl.save_store_target)
            r._4.store_size <= mem_addr_t'(ext_f3(r._1.inst));
    end

    // immediate extraction
    word_t imm;
    always_comb begin
        unique case (ctrl.opcode)
            OP_LUI:  imm = ext_u_imm(r._1.inst);
            OP_JALR: imm = ext_i_imm(r._1.inst);
            OP_IMM:  imm = ext_i_imm(r._1.inst);
            OP_AUIPC: imm = ext_u_imm(r._1.inst);
            OP_LOAD: imm = ext_i_imm(r._1.inst);
            OP_STORE: imm = ext_s_imm(r._1.inst);
            OP_BRANCH: imm = ext_b_imm(r._1.inst);
            OP_JAL:  imm = ext_j_imm(r._1.inst);
            default: imm = 'x; // no immediate for other instructions
        endcase
    end

    word_t alu_src_a;
    word_t alu_src_b;
    logic[2:0] alu_f3;
    logic alu_arith_bit;
`ifdef SHADD
    logic alu_shadd;
`endif
    logic alu_branch;
    word_t alu_out;
    sham_t alu_shamt_out;
    alu3 alu (
        .clk(clk),
        .start(ctrl.start),
        .src_a(alu_src_a),
        .src_b(alu_src_b),
        .f3(alu_f3),
        .arith_bit(alu_arith_bit),
`ifdef SHADD
        .shadd(alu_shadd),
`endif
        .branch(alu_branch),
        .out(alu_out),
        .shamt_out(alu_shamt_out),
        .done(done)
    );

    always_comb begin
        alu_src_a = r._2.r1;
        alu_src_b = 'X; // default ALU source B
        alu_f3 = FUNC_ADDSUB; // default ALU function
        alu_arith_bit = 0; // default arithmetic bit
`ifdef SHADD
        alu_shadd = 0; // default shift/add
`endif
        alu_branch = 0; // default branch
        unique case (ctrl.alu_ctrl)
            ALUC_PC_4: begin
                alu_src_a = {r.pc};
                alu_src_b = 4; // PC + 4
            end
            ALUC_PC_IMM: begin
                alu_src_a = {r.pc};
                alu_src_b = imm;
            end
            ALUC_RS1_4: begin
                alu_src_b = 4; // RS1 + 4
            end
            ALUC_RS1_IMM: begin
                alu_src_b = imm;
            end
            ALUC_OPEXE: begin
                alu_src_b = (ctrl.opcode == OP_OP || !ctrl.start) ? r._3.r2 : imm;
                alu_f3 = ext_f3(r._1.inst);
                alu_arith_bit = ext_arith_bit(r._1.inst) && (ctrl.opcode == OP_OP || ext_f3(r._1.inst) == FUNC_SR);
`ifdef SHADD
                alu_shadd = (ctrl.opcode == OP_OP && isShadd(r._1.inst));
`endif
            end
            ALUC_BRANCH_OP: begin
                alu_src_b = r._3.r2;
                alu_f3 = r._4.brf3;
                alu_branch = 1; // enable branch operation
            end
            default: begin
                // no operation, do nothing here.
            end
        endcase
    end

    assign cntr_addr = 2'(ext_i_imm(r._1.inst));

    // Register file
    always_comb begin
        regnum = ctrl.rf_rs1? regnum_t'(ext_rs1(r._1.inst)) :
                 ctrl.rf_rs2? regnum_t'(ext_rs2(r._1.inst)) :
                 (ctrl.opcode == OP_LUI) ? regnum_t'(ext_rd(r._1.inst)) : r._4.rd;
        
        unique case (ctrl.opcode)
            OP_LUI:  rfwrite_data = ext_u_imm(r._1.inst);
            OP_JALR: rfwrite_data = r._3.r2;
            OP_SYS:  rfwrite_data = r._3.cntr_data;
            OP_LOAD: rfwrite_data = memread_data;
            default: rfwrite_data = alu_out;
        endcase
    end

    // Memory
    always_comb begin
        memwrite_data = r._3.r2;
        unique case (1'b1)
            ctrl.opcode == OP_LOAD && ctrl.memop: begin
                mem_size = mem_addr_t'(ext_f3(r._1.inst));
                mem_addr = alu_out;
            end
            ctrl.opcode == OP_STORE && ctrl.memop: begin
                mem_size = r._4.store_size;
                mem_addr = r._2.store_address;
            end
            ctrl.alu_ctrl == ALUC_BRANCH_OP: begin
                mem_size = MEM_W; 
                mem_addr = (alu_out[0]) ? r._1.branch_target : {r.pc}; // branch target
            end
            default: begin
                mem_size = MEM_W;
                mem_addr = alu_out;
            end
        endcase
    end

    assign opcode = ext_opcode(ctrl.update_instr ? memread_data : r._1.inst);
        
endmodule