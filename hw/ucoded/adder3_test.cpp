#include "Vadder3.h"
#include "Vadder3___024root.h"

#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>
#include <cstdint>

enum Op {
    ADDER_ADD = 0b010,
    ADDER_SUB = 0b011,

    ADDER_EQ  = 0b000,
    ADDER_NE  = 0b001,
    ADDER_LT  = 0b100,
    ADDER_GE  = 0b101,
    ADDER_LTU = 0b110,
    ADDER_GEU = 0b111
};

std::string op_name(uint32_t op) {
    switch (op) {
        case ADDER_ADD: return "ADD";
        case ADDER_SUB: return "SUB";
        case ADDER_EQ: return "EQ";
        case ADDER_NE: return "NE";
        case ADDER_LT: return "LT";
        case ADDER_GE: return "GE";
        case ADDER_LTU: return "LTU";
        case ADDER_GEU: return "GEU";
    }
}

std::array<uint32_t, 39> test_inputs = {
    0x00000000, 0x00000001, 0x80000000, 0x7FFFFFFF, 0xFFFFFFFF, 0xDEADBEEF, 0xABCDEF01, 0x12345678, 0x87654321, 0x11111111,
    0x22222222, 0x33333333, 0x44444444, 0x55555555, 0x66666666, 0x77777777, 0x88888888, 0x99999999, 0xAAAAAAAA, 0xBBBBBBBB,
    0xCCCCCCCC, 0xDDDDDDDD, 0xEEEEEEEE, 0xFFFFFFFF, 0x10101010, 0x20202020, 0x30303030, 0x40404040, 0x50505050, 0x60606060,
    0x70707070, 0x80808080, 0x90909090, 0xA0A0A0A0, 0xB0B0B0B0, 0xC0C0C0C0, 0xD0D0D0D0, 0xE0E0E0E0, 0xF0F0F0F0
};


int run_test(Vadder3* top, VerilatedVcdC* tfp, uint64_t &sim_time,
             uint32_t src_a, uint32_t src_b, uint32_t op) {
    // Initialize values
    top->op = op;
    top->src_a = src_a;
    top->src_b = src_b;
    int cycles = 0;
    // Start the operation
    top->start = 1;
    top->clk = 0;
    top->eval();
    uint32_t result = top->out;
    tfp->dump(sim_time++);
    std::cout << "Cycle " << cycles++ << ": " << std::hex << result << std::endl;

    while (!top->done) {
        top->clk = 1;
        top->eval();
        tfp->dump(sim_time++);
        top->start = 0;
        top->src_a = result;        
        top->clk = 0;
        top->eval();
        tfp->dump(sim_time++);
        result = top->out;
        std::cout << "Cycle " << cycles++ << ": " << std::hex << result << std::endl;
    }

    // Log the expected and generated values
    uint32_t expected_result;
    
    switch (op) {
        case ADDER_ADD:
            expected_result = src_a + src_b;
            break;
        case ADDER_SUB:
            expected_result = src_a - src_b;
            break;
        case ADDER_EQ:
            expected_result = src_a == src_b;
            break;
        case ADDER_NE:
            expected_result = src_a != src_b;
            break;
        case ADDER_LT:
            expected_result = ((int32_t)src_a < (int32_t)src_b);
            break;
        case ADDER_GE:
            expected_result = ((int32_t)src_a >= (int32_t)src_b);
            break;
        case ADDER_LTU:
            expected_result = (src_a < src_b);
            break;
        case ADDER_GEU:
            expected_result = (src_a >= src_b);
            break;
        default:
            std::cout << "Unknown operation: " << op << std::endl;
            expected_result = 0;
            return -1;
    }
    std::cout << op_name(op) << " " << src_a << ", " << src_b << std::endl;
    // Check if the result matches the expected value
    if (result != expected_result) {
        std::cout << "Expected result: " << expected_result << std::endl;
        std::cout << "Generated result: " << result << std::endl;
        std::cout << "ERROR: Result mismatch!" << std::endl;
        return -1;
    }
    top->clk = 1;
    top->eval();
    tfp->dump(sim_time++);
    return 0;
    return cycles;
}

int run_tests_for_values(Vadder3* top, VerilatedVcdC* tfp, uint64_t &sim_time, uint32_t src_a, uint32_t src_b) {
    std::array<uint32_t, 8> op_names = {
        ADDER_ADD, ADDER_SUB,
        ADDER_EQ, ADDER_NE, ADDER_LT, ADDER_GE, ADDER_LTU, ADDER_GEU
    };
    for (uint32_t op : op_names) {
        if (run_test(top, tfp, sim_time, src_a, src_b, op) == -1) {
            return -1;
        }
    }
    return 0;
}

int main(int argc, char** argv) {
    // Initialize Verilator
    Verilated::commandArgs(argc, argv);
    
    // Enable VCD tracing
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    
    // Create instance of adder3
    Vadder3* top = new Vadder3;
    top->trace(tfp, 99);  // Trace 99 levels of hierarchy
    tfp->open("adder3.vcd");
    uint64_t sim_time = 0;
    top->start = 0;

    // Reset sequence
    top->rst = 1;  // Assert reset
    top->clk = 0;
    top->eval();
    tfp->dump(sim_time++);
    
    top->clk = 1;  // Clock cycle during reset
    top->eval();
    tfp->dump(sim_time++);
    
    top->rst = 0;  // Deassert reset
    
    for (uint32_t src_a : test_inputs) {
        for (uint32_t src_b : test_inputs) {
            if (run_tests_for_values(top, tfp, sim_time, src_a, src_b) == -1) {
                goto EXIT;
            }
        }
    }
EXIT:
    // Cleanup
    tfp->close();
    delete tfp;
    delete top;
    return 0;
} 