
function word_t pc2word(input pc_t pc);
    return {pc, 2'b00};
endfunction

function pc_t word2pc(input word_t addr);
    return addr[31:2];
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
    output logic forward,

    output opcode_t opcode,
    output opcode_t next_opcode,

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
    word_t r1, r2, ir /*verilator public*/, ir2;
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

    assign branch_taken = (opcode == OP_BRANCH) && ctrl.alu_op && alu.adder_out[0];

    pc_t pc_plus4;
    assign pc_plus4 = pc + 1;
    assign opcode = ext_opcode(ir);

    logic match_reg;
    logic[127:0] op1map, op2map; 
    always_comb begin
        op1map = 0;
        op2map = ~128'b0;
        op1map[OP_OP]   = 1;
        op1map[OP_IMM]  = 1;
        op1map[OP_LOAD] = 1;
        op1map[OP_AUIPC]= 1;
        op1map[OP_LUI]  = 1;
        op2map[OP_JAL]  = 0;
        op2map[OP_LUI]  = 0;
        op2map[OP_AUIPC]= 0;
        next_opcode = ext_opcode(ctrl.ir_src ? memread_data: r1);
        match_reg = (ext_rd(ir) == ext_rs1(ctrl.ir_src ? memread_data: r1)) && ext_rd(ir) != 0;
        forward = ctrl.set_ir && match_reg && op1map[opcode] && op2map[next_opcode];
    end

    always_ff @(posedge clk) begin
        if (ctrl.set_ir)
            ir <= ctrl.ir_src ? memread_data : ir2;

        ir2 <= memread_data;

        if (rst)
            pc <= 0;
        else if (ctrl.set_pc)
            pc <= word2pc(mux_src(ctrl.pc_src, pc2, pc_plus4, 'x, 'x, alu.adder_out, 'x));

        if (ctrl.set_r1) begin
            unique case (ctrl.r1_src)
                SRC_MEM: r1 <= memread_data;
                SRC_RF:  r1 <= rfread_data;
                SRC_ALU: r1 <= alu_out;
                default: r1 <= 'x;
            endcase
        end

        if (ctrl.set_r2) begin
            if (ctrl.r2_src)
                r2 <= rfread_data;
            else
`ifdef SHADD
            if (!alu_shadd) // FIXME a bit hacky
`endif
                r2[4:0] <= alu_shamt_out;
        end
        if (ctrl.set_pc2)
            pc2 <= word2pc(alu.adder_out);
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
        case (ctrl.rf_src)
            SRC_PC_PLUS4: rfwrite_data = pc2word(pc_plus4);
            SRC_MEM:      rfwrite_data = memread_data;
            SRC_ALU:      rfwrite_data = alu_out;
            SRC_CNTR:     rfwrite_data = cntr_data;
            default:      rfwrite_data = 'x;
        endcase
        // rfwrite_data = mux_src(ctrl.rf_src, 'x, pc_plus4, memread_data, 'x, alu_out, cntr_data);
    end

    // Memory
    always_comb begin
        memwrite_data = rfread_data;
        mem_addr = mux_src(ctrl.maddr_src, pc2, pc_plus4, 'x, 'x, alu.adder_out, 'x);
        mem_size = ctrl.memop ? mem_addr_t'(ext_f3(ir)) : MEM_W;
    end        
endmodule