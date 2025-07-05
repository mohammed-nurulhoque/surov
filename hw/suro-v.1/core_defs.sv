typedef enum {
    ALUC_PC_4 = 0,
    ALUC_PC_IMM,
    ALUC_RS1_4,
    ALUC_RS1_IMM,
    ALUC_OPEXE,
    ALUC_BRANCH_OP,
    ALUC_NONE
} alu_ctrl_t;

typedef struct {
    opcode_t opcode;      // Current opcode
    logic update_pc;      // Update PC
    logic update_instr;   // Read interrupt
    logic rf_rs1;         // Read RF rs1
    logic rf_rs2;         // Read RF rs2
    logic save_rd;        // Save rd
    logic save_op;        // Save opcode
    logic save_pc;        // Save PC to r1
    logic save_pc_next;   // Save next PC to r2
    logic save_br_target; // Save branch target address
    logic memop;          // Memory operation
    alu_ctrl_t alu_ctrl;  // ALU control signal
    logic start;          // 1st cycle of multicycle datapath operation
} ctrl_t;

typedef struct packed {
    word_t pc;            // Program counter
    union packed {
        word_t inst;          // Current instruction
        word_t branch_target; // Branch target address
    } _1;
    union packed {
        word_t r1;           // Register 1 value
        word_t saved_pc;     // Saved PC value
        word_t store_address; // Address for store operation
    } _2;
    union packed {
        word_t r2;           // Register 2 value
        word_t saved_pc_next;// Next PC value
    } _3;
    union packed{
        regnum_t rd;         // Destination register number
        opcode_t op;         // Current operation code
    } _4;
} dp_regs_t;