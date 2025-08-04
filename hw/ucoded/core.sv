`default_nettype none

`define CYCLE_INIT EX
`define INST_INIT 32'h00_00_00_07
`define NOP  32'b000000000000_00000_000_00000_0010011
`define OP_INIT 7'b0010011

typedef logic[4:0] regnum_t;

function logic has_d2 (input word_t inst);
    unique case (opcode_t'(ext_opcode(inst)))
        OP_IMM, OP_LUI, OP_AUIPC, OP_JAL, OP_FENCE, OP_SYS: has_d2 = 0;
        default: has_d2 = 1;
    endcase
endfunction

function logic d_read_rs (cycle_t cycle, input opcode_t op);
    if (cycle == D1) begin
        unique case (op)
            OP_LUI, OP_AUIPC, OP_JAL, OP_FENCE, OP_SYS: d_read_rs = 0;
            default: d_read_rs = 1;
        endcase
    end else begin
        unique case (op)
            OP_OP, OP_STORE, OP_BRANCH: d_read_rs = 1;
            default: d_read_rs = 0;
        endcase
    end
endfunction

function ex_rf_wren(opcode_t op);
    unique case (op)
        OP_BRANCH, OP_SYS, OP_FENCE, OP_STORE: ex_rf_wren = 0;
        default: ex_rf_wren = 1;
    endcase
endfunction


function logic is_read_mem (cycle_t cycle,
                            logic is_load,
                            logic is_store,
                            opcode_t op);
    unique case (cycle)
        D1: is_read_mem = 0;
        D2: is_read_mem = is_load | is_store;
        EX: is_read_mem = !(is_store | (!is_load & op==OP_BRANCH));
        BR: is_read_mem = 1;
    endcase
endfunction

module core
#(
    parameter int NUMREGS=32,
    localparam WDATA = 32,
    localparam WPTR = 32,
    localparam WSHAM = $clog2(WDATA),
    localparam WRFI = $clog2(NUMREGS)
) (
    input logic clk,
    input logic rst,

    output logic rf_read,
    output logic rf_wren,
    output logic[WRFI-1:0]  regnum,
    input  logic[WDATA-1:0] rfread_data,
    output logic[WDATA-1:0] rfwrite_data,

    output logic mem_read,
    output logic mem_wren,
    output logic[WPTR-1:0]  mem_addr,
    output mem_addr_t mem_size,
    input  logic[WDATA-1:0] memread_data,
    output logic[WDATA-1:0] memwrite_data,

    output logic host_trap
);
    logic[WPTR-1:0] pc;
    logic[WPTR-1:0] pc_next;
    cycle_t cycle /*verilator public*/;
    word_t inst   /*verilator public*/;
    word_t rs1;
    word_t rs2;
    word_t saved_addr; // lsu address and branch target
    mem_addr_t saved_mem_size;
    regnum_t loadrd;
    reg is_load;
    reg is_store;

    wire is_loadstore = is_load | is_store;
    wire sig_has_d2 = has_d2(inst);

    opcode_t opcode;
    assign opcode = ext_opcode(inst);

    // state variables
    always_ff @(posedge clk) begin
        // reset
        if (rst) begin
            pc_next  <= memread_data;
            cycle    <= `CYCLE_INIT;
            inst     <= `INST_INIT;
            is_load  <= 0;
            is_store <= 0;
        end else unique case (cycle)
            D1: begin
                cycle <= sig_has_d2 ? D2 : EX;
                pc_next <= adder_out; // garbage for jalr
                is_load <= opcode == OP_LOAD;
                is_store <= opcode == OP_STORE;
            end
            D2: begin
                cycle <= EX;
                unique case (opcode)
                    OP_JALR: pc_next <= adder_out;
                    OP_LOAD, OP_STORE: begin
                        loadrd <= (is_load)? ext_rd(inst) : 0;
                        inst <= memread_data;
                        saved_addr <= adder_out;
                        saved_mem_size <= mem_addr_t'(ext_f3(inst));
                    end
                    OP_BRANCH: saved_addr <= adder_out;
                endcase
            end
            EX: begin // cannot read opcode for load/store
                if (is_loadstore) begin
                    cycle <= D1;
                    pc <= pc_next;
                    is_load <= 0;
                    is_store <= 0;
                end else if (opcode == OP_BRANCH) begin
                    cycle <= BR;
                    pc_next <= alu_out[0] ? saved_addr : pc_next;
                end else begin
                    cycle <= D1;
                    pc <= pc_next;
                    inst <= memread_data;
                end
            end
            BR: begin
                cycle <= D1;
                pc <= pc_next;
                inst <= memread_data;
            end
        endcase
    end

    adderOp_t adder_op;
    word_t adder_a, adder_b, adder_out;

    // adder_op
    always_comb begin
        adder_op = ADDER_ADD;
        if (cycle==EX) begin
            unique case (opcode)
                OP_OP, OP_IMM: begin
                    unique case (ext_f3(inst))
                        FUNC_ADDSUB: adder_op = 
                            (opcode == OP_OP & ext_arith_bit(inst))? ADDER_SUB: ADDER_ADD;
                        FUNC_SLT:    adder_op = ADDER_LT;
                        FUNC_SLTU:   adder_op = ADDER_LTU;
                    endcase
                end
                OP_BRANCH: case (ext_f3(inst)) 
                    BR_EQ: adder_op = ADDER_EQ;
                    BR_NE: adder_op = ADDER_NE;
                    BR_LT: adder_op = ADDER_LT;
                    BR_LTU:adder_op = ADDER_LTU;
                    BR_GE: adder_op = ADDER_GE;
                    BR_GEU:adder_op = ADDER_GEU;
                endcase
            endcase
        end
    end

    // adder_a / adder_b
    always_comb begin
        adder_a = 'X;
        adder_b = 'X;
        unique case (cycle)
            D1: begin // junk for jalr
                adder_a = pc;
                adder_b = (opcode == OP_JAL)? ext_j_imm(inst) : 4;
            end
            D2: begin
                unique case (opcode)
                    OP_JALR, OP_LOAD: begin
                        adder_a = rs1;
                        adder_b = ext_i_imm(inst);
                    end
                    OP_STORE: begin
                        adder_a = rs1;
                        adder_b = ext_s_imm(inst);
                    end
                    OP_BRANCH: begin
                        adder_a = pc;
                        adder_b = ext_b_imm(inst);
                    end
                endcase
            end
            EX: begin if (!is_loadstore)
                unique case (opcode)
                    OP_OP, OP_BRANCH: begin
                        adder_a = rs1;
                        adder_b = rs2;
                    end
                    OP_IMM : begin
                        adder_a = rs1;
                        adder_b = ext_i_imm(inst);
                    end
                    OP_AUIPC: begin
                        adder_a = pc;
                        adder_b = ext_u_imm(inst);
                    end
                    OP_JAL, OP_JALR: begin
                        adder_a = pc;
                        adder_b = 4;
                    end
                endcase
            end
        endcase
    end

    logic adder_cout;
    adder a(adder_op, adder_a, adder_b, adder_out, adder_cout);

    wire sig_sr = opFunc_t'(ext_f3(inst)) == FUNC_SR;
    wire sig_sa = ext_arith_bit(inst);
    sham_t sham;
    assign sham = sham_t'(((opcode == OP_OP)? rs2 : ext_i_imm(inst)));
    word_t shifter_out;
    shifter #(.WIDTH(WDATA)) sh(rs1, sham, sig_sr, sig_sa, shifter_out);

    word_t alu_out;
    always_comb begin
        alu_out = adder_out;
        if (cycle == EX & !is_loadstore)
            unique case (opcode)
                OP_OP, OP_IMM: unique case (ext_f3(inst))
                    FUNC_SLL, FUNC_SR: alu_out = shifter_out;
                    FUNC_XOR: alu_out = adder_a ^ adder_b;
                    FUNC_AND: alu_out = adder_a & adder_b;
                    FUNC_OR:  alu_out = adder_a | adder_b;
                endcase
                OP_LUI: alu_out = ext_u_imm(inst);
            endcase
    end

    // regfile read/write
    always_comb begin
        regnum = 'X;
        rfwrite_data = 'X;
        rf_read = 0;
        unique case (cycle)
            D1, D2: begin
                rf_wren = 0;
                rf_read = d_read_rs(cycle, opcode);
                regnum = (cycle == D1)? ext_rs1(inst) : ext_rs2(inst); // junk for jalr
            end
            EX: begin
                if (is_loadstore) begin
                    rf_wren = is_load;
                    regnum = loadrd;
                    rfwrite_data = memread_data;
                end else begin
                    rf_wren = ex_rf_wren(opcode);
                    regnum = ext_rd(inst);
                    rfwrite_data = alu_out;
                end
            end
            BR: begin
                rf_wren = 0;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        unique case (cycle)
            D1: rs1 <= rfread_data;
            D2: rs2 <= rfread_data;
        endcase
    end

    always_comb begin
        memwrite_data = rs2;
        mem_addr = pc_next;
        mem_read = is_read_mem(cycle, is_load, is_store, opcode);
        mem_wren = 0;
        mem_size = MEM_W;
        if (cycle == EX & is_loadstore) begin
            mem_wren = is_store;
            mem_addr = saved_addr;
            mem_size = saved_mem_size;
        end 
    end

    assign host_trap = (cycle == D1 & opcode == OP_SYS);
endmodule
