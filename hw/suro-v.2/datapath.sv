
function word_t pc2word(input pc_t pc);
    return word_t'(pc) << 2;
endfunction

function pc_t word2pc(input word_t addr);
    return pc_t'(addr >> 2);
endfunction

function word_t mux_src(
    src_t src,
    pc_t pc2,
    pc_t pc_plus4,
    word_t memout,
    word_t rfout,
    word_t aluout,
    word_t cntrdata);
    case (src)
        SRC_PC2:   return pc2word(pc2);
        SRC_MEM:   return memout;
        SRC_RF:    return rfout;
        SRC_ALU:   return aluout;
        SRC_PC_PLUS4: return pc2word(pc_plus4);
        SRC_CNTR:  return cntrdata;
        default:   return 'x; // invalid source
    endcase
endfunction

function word_t ext_imm(input word_t ir);
    unique case (ext_opcode(ir))
        OP_LUI:    return ext_u_imm(ir);
        OP_JALR:   return ext_i_imm(ir);
        OP_IMM:    return ext_i_imm(ir);
        OP_AUIPC:  return ext_u_imm(ir);
        OP_LOAD:   return ext_i_imm(ir);
        OP_STORE:  return ext_s_imm(ir);
        OP_BRANCH: return ext_b_imm(ir) - 4;
        OP_JAL:    return ext_j_imm(ir);
        default:   return 'x; // no immediate for other instructions
    endcase
endfunction

module datapath (
    input logic clk,
    input logic rst,

    input ctrl_t ctrl,
    output logic done,
    output logic branch_taken,

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
    // state registers
    word_t r1, r2, ir /*verilator public*/;
    pc_t pc /*verilator public*/;
    pc_t pc2;

    // ALU wires
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

    assign branch_taken = (opcode == OP_BRANCH) && ctrl.alu_op && alu_out[0];

    pc_t pc_plus4;
    assign pc_plus4 = pc + 1;
    assign opcode = ext_opcode(ir);

    always_ff @(posedge clk) begin
        if (rst)
            ir <= {25'bx, OP_JALR};
        else if (ctrl.set_ir && done)
            ir <= memread_data;

        if (ctrl.set_pc)
            pc <= word2pc(mux_src(ctrl.pc_src, pc2, pc_plus4, 'x, 'x, alu_out, 'x));
        if (ctrl.set_r1)
            r1 <= mux_src(ctrl.r1_src, 'x, 'x, memread_data, rfread_data, alu_out, 'x);
        
        if (ctrl.set_r2) begin
            if (ctrl.r2_src)
                r2 <= rfread_data;
            else if (!alu_shadd) // FIXME a bit hacky
                r2 <= {27'bx, alu_shamt_out};
        end
        if (ctrl.set_pc2)
            pc2 <= word2pc(alu_out);
    end

    // ALU operation
    word_t imm;
    always_comb begin
        imm = ext_imm(ir);
        alu_src_a = ctrl.alu_a_r1 ? r1: pc2word(pc);
        alu_src_b = ctrl.alu_b_r2 ? r2: imm;
        
        alu_f3 = FUNC_ADDSUB; // default ALU function
        alu_arith_bit = 0; // default arithmetic bit
        alu_branch = 0; // default branch
`ifdef SHADD
        alu_shadd = 0; // default shift/add
`endif
        if (ctrl.alu_op) begin
            alu_f3 = ext_f3(ir);
            alu_arith_bit = ext_arith_bit(ir) && (opcode == OP_OP || ext_f3(ir) == FUNC_SR);
            alu_branch = opcode == OP_BRANCH;
`ifdef SHADD
            alu_shadd = (opcode == OP_OP && isShadd(ir));
`endif
        end
    end

    assign cntr_addr = 2'(ext_i_imm(ir));

    // Register file
    always_comb begin
        unique case (ctrl.rf_regnum_src)
            X0:  regnum = 5'h0;
            RS1: regnum = ext_rs1(ir);
            RS2: regnum = ext_rs2(ir);
            RD:  regnum = ext_rd(ir);
        endcase
        
        rfwrite_data = mux_src(ctrl.rf_src, 'x, pc_plus4, 'x, 'x, alu_out, cntr_data);
    end

    // Memory
    always_comb begin
        memwrite_data = rfread_data;
        mem_addr = mux_src(ctrl.maddr_src, pc2, pc_plus4, 'x, 'x, alu_out, 'x);
        mem_size = ctrl.memop ? mem_addr_t'(ext_f3(ir)) : MEM_W;
    end        
endmodule