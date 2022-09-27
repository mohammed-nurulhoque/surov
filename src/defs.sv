typedef bit[31:0] word_t;
typedef bit[4:0]  regnum_t;
typedef bit[11:0] i_imm;
typedef bit[11:0] s_imm;
typedef bit[19:0] u_imm;

typedef enum { ALU_NOP, ALU_ADD, ALU_SUB, ALU_AND, ALU_OR, ALU_XOR,
               ALU_SLL, ALU_SRL, ALU_SRA } ALU_f;

typedef enum bit[4:0] {
    OP_LOAD     = 5'b00_000,
    OP_STORE    = 5'b01_000,
    OP_BRANCH   = 5'b11_000,
    OP_JAL      = 5'b11_011,
    OP_JALR     = 5'b11_001,
    OP_OP       = 5'b01_100,
    OP_IMM      = 5'b00_100,
    OP_AUIPC    = 5'b00_101,
    OP_LUI      = 5'b01_101
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
} opF3_t;


function regnum_t ext_rd (input word_t instr);
    return instr[11:7];
endfunction

function regnum_t ext_rs1 (input word_t instr);
    return instr[19:15];
endfunction

function regnum_t ext_rs2 (input word_t instr);
    return instr[24:20];
endfunction

function opF3_t ext_f3 (input word_t instr);
    return opF3_t'(instr[14:12]);
endfunction

function opcode_t ext_opcode (input word_t instr);
    return opcode_t'(instr[6:2]);
endfunction

function logic isAShift (input word_t instr);
    return instr[30];
endfunction

function logic isSubtract (input word_t instr);
    return instr[30];
endfunction

word_t NOP = 32'b000000000000_00000_000_00000_0010011;