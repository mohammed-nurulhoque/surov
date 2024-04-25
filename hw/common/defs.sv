typedef bit[31:0] word_t;
typedef bit[4:0]  regnum_t;
typedef bit[11:0] i_imm;
typedef bit[11:0] s_imm;
typedef bit[19:0] u_imm;

typedef enum bit[4:0] { ALU_NOP, ALU_ADD, ALU_SUB, ALU_AND, ALU_OR, ALU_XOR,
                        ALU_SLL, ALU_SRL, ALU_SRA, ALU_SLT, ALU_SLTU } ALU_f;

typedef enum bit[6:0] {
    OP_LOAD     = 7'b00_000_11,
    OP_STORE    = 7'b01_000_11,
    OP_BRANCH   = 7'b11_000_11,
    OP_JAL      = 7'b11_011_11,
    OP_JALR     = 7'b11_001_11,
    OP_OP       = 7'b01_100_11,
    OP_IMM      = 7'b00_100_11,
    OP_AUIPC    = 7'b00_101_11,
    OP_LUI      = 7'b01_101_11
} opcode_t;

typedef enum bit[2:0] {
    FUNC_ADD  = 3'b000,
    FUNC_SLT  = 3'b010,
    FUNC_SLTU = 3'b011,
    FUNC_XOR  = 3'b100,
    FUNC_OR   = 3'b110,
    FUNC_AND  = 3'b111,
    FUNC_SLL  = 3'b001,
    FUNC_SR   = 3'b101
} opFunc_t;

typedef enum bit[2:0] { 
    BR_EQ  = 3'b000,
    BR_NE  = 3'b001,
    BR_LT  = 3'b100,
    BR_GE  = 3'b101,
    BR_LTU = 3'b110,
    BR_GEU = 3'b111
 } branch_t;

typedef enum bit[2:0] {
    MEM_B = 3'b000,
    MEM_H = 3'b001,
    MEM_W = 3'b010,
    MEM_BU = 3'b100,
    MEM_HU = 3'b101
} mem_addr_t;

function regnum_t ext_rd (input word_t inst);
    return inst[11:7];
endfunction

function regnum_t ext_rs1 (input word_t inst);
    return inst[19:15];
endfunction

function regnum_t ext_rs2 (input word_t inst);
    return inst[24:20];
endfunction

function logic[2:0] ext_f3 (input word_t inst);
    return inst[14:12];
endfunction

function opcode_t ext_opcode (input word_t inst);
    return opcode_t'(inst[6:0]);
endfunction

function word_t ext_i_imm (input word_t inst);
    return { {21{inst[31]}}, inst[30:20] };
endfunction

function word_t ext_s_imm (input word_t inst);
    return { {21{inst[31]}}, inst[30:25], inst[11:7] };
endfunction

function word_t ext_b_imm (input word_t inst);
    return { {20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0 };
endfunction

function word_t ext_u_imm (input word_t inst);
    return { inst[31:12], 12'h000 };
endfunction

function word_t ext_j_imm (input word_t inst);
    return { inst[31], inst[30:20], inst[19:12], 12'h000 };
endfunction

function logic isAShift (input word_t inst);
    return inst[30];
endfunction

function logic isSubtract (input word_t inst);
    return inst[30];
endfunction

word_t NOP = 32'b000000000000_00000_000_00000_0010011;
