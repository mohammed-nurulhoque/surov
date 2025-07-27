`define REG_COUNT 32
typedef logic[$clog2(`REG_COUNT)-1:0]  regnum_t;

typedef enum {
    ALUC_PC_4 = 0,
    ALUC_PC_IMM,
    ALUC_RS1_4,
    ALUC_RS1_IMM,
    ALUC_OPEXE,
    ALUC_BRANCH_OP,
    ALUC_NONE
} alu_ctrl_t;

typedef struct packed {
    opcode_t opcode;      // Current opcode
    logic update_pc;      // Update PC
    logic update_instr;   // Read interrupt
    logic update_cntr_data;
    logic rf_rs1;         // Read RF rs1
    logic rf_rs2;         // Read RF rs2
    logic save_rd;        // Save rd
    logic save_f3;        // Save f3
    logic save_pc;        // Save PC to r1
    logic save_pc_next;   // Save next PC to r2
    logic save_br_target; // Save branch target address
    logic save_store_target;
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
        word_t cntr_data;    // zicntr data
        word_t saved_pc_next;// Next PC value
    } _3;
    union packed{
        regnum_t rd;         // Destination register number
        mem_addr_t store_size;  // store size
        branch_t brf3;       // branch op
    } _4;
} dp_regs_t;

typedef enum {
    CNTR_CYCLE
} cntr_t;
`define INST_INIT 32'h6f
`define CYCLE_INIT 0
