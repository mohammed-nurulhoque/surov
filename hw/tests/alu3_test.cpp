#include "Valu3.h"
#include "Valu3___024root.h"

#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>
#include <cstdint>

enum opFunc_t {
    FUNC_ADDSUB  = 0b000,
    FUNC_SLT     = 0b010,
    FUNC_SLTU    = 0b011,
    FUNC_XOR     = 0b100,
    FUNC_OR      = 0b110,
    FUNC_AND     = 0b111,
    FUNC_SLL     = 0b001,
    FUNC_SR      = 0b101
};

enum branch_t { 
    BR_EQ  = 0b000,
    BR_NE  = 0b001,
    BR_LT  = 0b100,
    BR_GE  = 0b101,
    BR_LTU = 0b110,
    BR_GEU = 0b111
};

enum op_t {
    ALU_ADD,
    ALU_SUB,
    ALU_SLL,
    ALU_SRL,
    ALU_SRA,
    ALU_AND,
    ALU_OR,
    ALU_XOR,
    ALU_SLT,
    ALU_SLTU,

    ALU_EQ ,
    ALU_NE ,
    ALU_LT ,
    ALU_GE ,
    ALU_LTU,
    ALU_GEU,

    ALU_SH1ADD,
    ALU_SH2ADD,
    ALU_SH3ADD,
    
    ALU_OP_COUNT
};

static const uint8_t f3_map[ALU_OP_COUNT] = {
    [ALU_ADD]    = FUNC_ADDSUB,  // ADD operation
    [ALU_SUB]    = FUNC_ADDSUB,  // SUB operation (arith_bit=1)
    [ALU_SLL]    = FUNC_SLL,     // Shift left logical
    [ALU_SRL]    = FUNC_SR,      // Shift right logical (arith_bit=0)
    [ALU_SRA]    = FUNC_SR,      // Shift right arithmetic (arith_bit=1)
    [ALU_AND]    = FUNC_AND,     // Bitwise AND
    [ALU_OR]     = FUNC_OR,      // Bitwise OR
    [ALU_XOR]    = FUNC_XOR,     // Bitwise XOR
    [ALU_SLT]    = FUNC_SLT,     // Set less than (signed)
    [ALU_SLTU]   = FUNC_SLTU,    // Set less than unsigned
    [ALU_EQ]     = BR_EQ,        // Branch equal
    [ALU_NE]     = BR_NE,        // Branch not equal
    [ALU_LT]     = BR_LT,        // Branch less than (signed)
    [ALU_GE]     = BR_GE,        // Branch greater or equal (signed)
    [ALU_LTU]    = BR_LTU,       // Branch less than unsigned
    [ALU_GEU]    = BR_GEU,       // Branch greater or equal unsigned
    [ALU_SH1ADD] = 0b010,  // Shift-add 1 (shadd operation)
    [ALU_SH2ADD] = 0b100,  // Shift-add 2 (shadd operation)
    [ALU_SH3ADD] = 0b110   // Shift-add 3 (shadd operation)
};

static const char* op_name[ALU_OP_COUNT] = {
    "ADD", "SUB", "SLL", "SRL", "SRA", "AND", "OR", "XOR", "SLT", "SLTU",
    "EQ", "NE", "LT", "GE", "LTU", "GEU",
    "SH1ADD", "SH2ADD", "SH3ADD"
};

int main(int argc, char** argv) {
    // Initialize Verilator
    Verilated::commandArgs(argc, argv);
    
    // Enable VCD tracing
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    
    // Create instance of alu3
    Valu3* top = new Valu3;
    top->trace(tfp, 99);  // Trace 99 levels of hierarchy
    tfp->open("alu3.vcd");
    uint64_t sim_time = 0;
    top->clk = 0;
    
    for (int i=0; i<1000000; i++) {
        op_t op;
        uint32_t src_a, src_b;
        // Generate random operation
        op = static_cast<op_t>(rand() % ALU_OP_COUNT);
        
        // Generate random source values
        src_a = rand();
        src_b = rand();
        
        // For shift operations, limit src_b to 0-31
        if (op == ALU_SLL || op == ALU_SRA || op == ALU_SRL) {
            src_b = src_b & 0x1F;  // Mask to 5 bits (0-31)
        }

        top->src_a = src_a;
        top->src_b = src_b;
        top->f3 = f3_map[op];
        top->arith_bit = (op ==ALU_SUB || op == ALU_SRA);
        top->shadd = (op == ALU_SH1ADD || op == ALU_SH2ADD || op == ALU_SH3ADD);
        top->branch = (op >= ALU_EQ && op <= ALU_GEU);
        top->start = 1;
        top->eval();
        tfp->dump(sim_time++);

        if (op == ALU_SLL || op == ALU_SRL || op == ALU_SRA) {
            while (top->done == 0) {
                uint32_t out = top->out;
                uint32_t shamt_out = top->shamt_out;
                top->clk = 1;
                top->eval();
                tfp->dump(sim_time++);
                top->src_a = out;
                top->src_b = shamt_out;
                top->start = 0;
                top->clk = 0;
                top->eval();
                tfp->dump(sim_time++);
            }
        }

        uint32_t out = top->out;
        uint32_t expected_out = 0;
        switch (op) {
            case ALU_ADD:
                expected_out = src_a + src_b;
                break;
            case ALU_SUB:
                expected_out = src_a - src_b;
                break;
            case ALU_SLL:
                expected_out = src_a << src_b;
                break;
            case ALU_SRL:
                expected_out = src_a >> src_b;
                break;
            case ALU_SRA:
                expected_out = src_a >> src_b;
                break;
            case ALU_AND:
                expected_out = src_a & src_b;
                break;
            case ALU_OR:
                expected_out = src_a | src_b;
                break;
            case ALU_XOR:
                expected_out = src_a ^ src_b;
                break;
            case ALU_SLT:
                expected_out = (int32_t)src_a < (int32_t)src_b;
                break;
            case ALU_SLTU:
                expected_out = src_a < src_b;
                break;
            case ALU_EQ:
                expected_out = (src_a == src_b);
                break;
            case ALU_NE:
                expected_out = (src_a != src_b);
                break;
            case ALU_LT:
                expected_out = (int32_t)src_a < (int32_t)src_b;
                break;
            case ALU_GE:
                expected_out = (int32_t)src_a >= (int32_t)src_b;
                break;
            case ALU_LTU:
                expected_out = src_a < src_b;
                break;
            case ALU_GEU:
                expected_out = src_a >= src_b;
                break;
            case ALU_SH1ADD:
                expected_out = (src_a << 1) + src_b;
                break;
            case ALU_SH2ADD:
                expected_out = (src_a << 2) + src_b;
                break;
            case ALU_SH3ADD:
                expected_out = (src_a << 3) + src_b;
                break;
        }
        if (expected_out != out) {
            std::cout << i << ": Error: op=" << op_name[op]
                      << " src_a=0x" << std::hex << src_a << " src_b=0x" << src_b
                      << " expected_out=0x" << expected_out << " out=0x" << out << std::dec << "\n";
            goto EXIT;
        }
    }
    std::cout << "Success\n";
EXIT:
    // Cleanup
    tfp->close();
    delete tfp;
    delete top;
    return 0;
} 