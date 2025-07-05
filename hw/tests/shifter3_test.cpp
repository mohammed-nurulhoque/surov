#include "Vshifter3.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>
#include <cstdint>

bool test_case(Vshifter3* top, VerilatedVcdC* tfp, uint64_t& sim_time,
               uint32_t input, int32_t shift_amount, bool right_shift, bool arith_shift) {
    top->val_i = input;
    top->sham_i = shift_amount;
    top->right_shift = right_shift;
    top->arith_shift = arith_shift;
    top->start = 1;
    top->clk = 0;
    top->eval();
    tfp->dump(sim_time++);
    while (!top->done) {
        uint32_t val_tmp = top->val_o;
        uint32_t sham_tmp = top->sham_o;
        top->clk = 1;
        top->eval();
        tfp->dump(sim_time++);
        top->start = 0;
        top->val_i = val_tmp;
        top->sham_i = sham_tmp;
        top->clk = 0;
        top->eval();
        tfp->dump(sim_time++);
        if (sim_time > 100000) {
            std::cout << "Test failed! Timeout" << std::endl;
            return 1;
        }
    }

    int32_t expected = right_shift ? 
        arith_shift ? ((int32_t)input >> shift_amount) : ((uint32_t)input >> shift_amount) : 
        (input << shift_amount);
            // Check result
    if (top->val_o != expected) {
        std::cout << "Test failed!" << std::endl;
        std::cout << "Input: 0x" << std::hex << input << std::endl;
        std::cout << "Shift amount: " << shift_amount << std::endl;
        std::cout << "Right shift: " << right_shift << std::endl;
        std::cout << "Arithmetic shift: " << arith_shift << std::endl;
        std::cout << "Expected: 0x" << expected << std::endl;
        std::cout << "Got: 0x" << top->val_o << std::endl;
        return 1;
    }
    top->start = 0;
    top->clk = 1;
    top->eval();
    tfp->dump(sim_time++);
    return 0;
}

int main(int argc, char** argv) {
    // Initialize Verilator
    Verilated::commandArgs(argc, argv);
    
    // Enable VCD tracing
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    
    // Create instance of shifter3
    Vshifter3* top = new Vshifter3;
    top->trace(tfp, 99);  // Trace 99 levels of hierarchy
    tfp->open("shifter3.vcd");
    
    // Initialize clock and reset
    top->clk = 0;
    top->rst = 1;
    top->start = 0;
    
    // Reset sequence
    top->eval();
    tfp->dump(0);  // Dump waveform at time 0
    top->clk = 1;
    top->eval();
    tfp->dump(1);  // Dump waveform at time 1
    top->clk = 0;
    top->eval();
    tfp->dump(2);  // Dump waveform at time 2

    top->rst = 0;
    
    std::vector<uint32_t> test_inputs = {
        0,
        1, (uint32_t)-1,
        2, (uint32_t)-2,
        3, (uint32_t)-3,
        7, (uint32_t)-7,
        8, (uint32_t)-8,
        9, (uint32_t)-9,
        15, (uint32_t)-15,
        16, (uint32_t)-16,
        127, (uint32_t)-127,
        128, (uint32_t)-128,
        129, (uint32_t)-129,
        255, (uint32_t)-255,
        256, (uint32_t)-256,
        257, (uint32_t)-257,
        511, (uint32_t)-511,
        512, (uint32_t)-512,
        513, (uint32_t)-513,
        1023, (uint32_t)-1023,
        1024, (uint32_t)-1024,
        1025, (uint32_t)-1025,
        0xdeadbeef,
        0xabcdef01,
        0x12345678,
        0x87654321,
        0x11111111,
        0x22222222,
        0x33333333,
        0xffffffff
    };
    
    std::vector<int32_t> test_shift_amounts = {
        0, 1, 2, 3, 7, 8, 9, 15, 16, 30, 31        
    };

    // Run tests
    uint64_t sim_time = 3;  // Start after reset sequence
    for (const auto& input : test_inputs) {
        for (const auto& shift_amount : test_shift_amounts) {
            if (test_case(top, tfp, sim_time, input, shift_amount, false, false) ||
                test_case(top, tfp, sim_time, input, shift_amount, true, true) ||
                test_case(top, tfp, sim_time, input, shift_amount, true, false)) 
            {
                tfp->close();
                delete tfp;
                delete top;
                return 1;
            }
        }
    }
    
    std::cout << "All tests passed!" << std::endl;
    
    // Cleanup
    tfp->close();
    delete tfp;
    delete top;
    return 0;
} 