typedef bit[31:0] word_t;
typedef bit[4:0]  regnum_t;
typedef bit[11:0] i_imm;
typedef bit[11:0] s_imm;
typedef bit[19:0] u_imm;

typedef enum { ALU_NOP, ALU_ADD, ALU_SUB, ALU_AND, ALU_OR, ALU_XOR,
               ALU_SLT, ALU_SLTU,
               ALU_SLL, ALU_SRL, ALU_SRA } ALU_f;

typedef enum bit[4:0] {
    OP_LOAD     = 5'b00_000,
    OP_STORE    = 5'b01_000,
    OP_BRANCH   = 5'b11_000,
    OP_JAL      = 5'b11_011,
    OP_JALR     = 5'b11_001,
    OP          = 5'b01_100,
    OP_IMM      = 5'b00_100,
    OP_AUIPC    = 5'b00_101,
    OP_LUI      = 5'b01_101
} opcode_t;

typedef enum bit[2:0] {
    OPIMM_ADDI  = 3'b000,
    OPIMM_SLTI  = 3'b010,
    OPIMM_SLTIU = 3'b011,
    OPIMM_XORI  = 3'b100,
    OPIMM_ORI   = 3'b110,
    OPIMM_ANDI  = 3'b111,
    OPIMM_SLLI  = 3'b001,
    OPIMM_SRI   = 3'b101
} opimmF3_t;


module ext_rd (input word_t instr, output regnum_t rd);
    assign rd = instr[11:7];
endmodule

module ext_rs1 (input word_t instr, output regnum_t rs1);
    assign rs1 = instr[19:15];
endmodule

module ext_rs2 (input word_t instr, output regnum_t rs2);
    assign rs2 = instr[24:20];
endmodule

module ext_f3 (input word_t instr, output opimmF3_t f3);
    assign f3 = opimmF3_t'(instr[14:12]);
endmodule

module ext_opcode (input word_t instr, output opcode_t op);
    assign op = opcode_t'(instr[6:2]);
endmodule

module isSR_arith (input word_t instr, output logic out);
    assign out = instr[30];
endmodule

word_t NOP = 32'b000000000000_00000_000_00000_0010011;