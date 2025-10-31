typedef logic[29:0] pc_t;
typedef logic[$clog2(`REG_COUNT)-1:0]  regnum_t;
typedef logic[1:0] cntr_t;

typedef enum logic[2:0] {
    SRC_PC2,
    SRC_MEM,
    SRC_RF,
    SRC_ALU,
    SRC_PC_PLUS4,
    SRC_CNTR
} src_t;

typedef enum logic[1:0] {
    X0, RS1, RS2, RD
} regnum_src_t;

typedef struct packed {
    logic set_r1;     // Whether to set register 1
    src_t r1_src;     // Source for register 1
    logic set_r2;     // Whether to set register 2
    logic r2_src;     // Source for r2 is RF read, else ALU shamt_out
    logic set_pc;     // Whether to set program counter
    src_t pc_src;     // Source for program counter
    logic set_pc2;    // Whether to set pc2
    logic set_ir;     // Whether to set instruction register
    logic ir_src;     // ir source is memread_data, else ir2
    src_t rf_src;     // Source for register file write data
    regnum_src_t rf_regnum_src; // Source for register file write register number
    src_t maddr_src;  // Source for memory address
    logic memop;      // Memory operation (load/store)
    logic alu_a_r1;   // Source for ALU operand A is r1, else pc
    logic alu_b_r2;   // Source for ALU operand B is r2, else imm
    logic alu_op;     // Normal ALU operation of OP-OP OP-IMM or branch conditon
    logic start;      // 1st cycle of multicycle datapath operation
} ctrl_t;

`define INST_INIT `XLEN'h6f
`define CYCLE_INIT 0
