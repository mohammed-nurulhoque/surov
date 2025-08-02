`define REG_COUNT 32
typedef logic[31:0] pc_t;
typedef logic[$clog2(`REG_COUNT)-1:0]  regnum_t;
typedef logic[1:0] cntr_t;
typedef enum bit[6:0] {
    ALUC_PC_4      = 7'b0000001,
    ALUC_PC_IMM    = 7'b0000010,
    ALUC_RS1_4     = 7'b0000100,
    ALUC_RS1_IMM   = 7'b0001000,
    ALUC_OPEXE     = 7'b0010000,
    ALUC_BRANCH_OP = 7'b0100000,
    ALUC_NONE      = 7'b1000000
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
    pc_t pc;            // Program counter
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

`define INST_INIT `XLEN'h6f
`define CYCLE_INIT 0
