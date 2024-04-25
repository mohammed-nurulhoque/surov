#include <cstdlib>
#include <iostream>
#include <ctime>
#include <vector>

#include <verilated.h>

#include "Valu.h"
#include "Valu___024unit.h"

const unsigned ITERS_DEFAULT = 100;

typedef enum { ALU_NOP, ALU_ADD, ALU_SUB, ALU_AND, ALU_OR, ALU_XOR,
               ALU_SLL, ALU_SRL, ALU_SRA, ALU_SLT, ALU_SLTU, Count} ALU_f;

void print_help(char *bin, int ecode) {
    printf("Usage %s [-i test-iters] [-h]\n", bin);
    exit(ecode);
}

int main(int argc, char *argv[]) {
    unsigned test_iters = ITERS_DEFAULT;
    Valu *dut = new Valu;
    std::srand(0);

    for (unsigned i = 0; i < test_iters; i++) {
        dut->func = std::rand() % ALU_f::Count;
        dut->src_a = std::rand();
        dut->src_b = std::rand();
        dut->eval();
        switch (dut->func)
        {
        case ALU_f::ALU_ADD:
            assert(dut->out == dut->src_a + dut->src_b);
            break;
        case ALU_f::ALU_SUB:
            assert(dut->out == dut->src_a - dut->src_b);
            break;
        case ALU_f::ALU_AND:
            assert(dut->out == (dut->src_a & dut->src_b));
            break;
        case ALU_f::ALU_OR:
            assert(dut->out == (dut->src_a | dut->src_b));
            break;
        case ALU_f::ALU_XOR:
            assert(dut->out == (dut->src_a ^ dut->src_b));
            break;
        case ALU_f::ALU_SLT:
            assert(dut->out == dut->src_a < dut->src_b);
            break;
        case ALU_f::ALU_SLTU:
            assert(dut->out == (unsigned)dut->src_a < (unsigned)dut->src_b);
            break;
        case ALU_f::ALU_SLL:
            assert(dut->out == dut->src_a << (dut->src_b & 31));
            break;
        case ALU_f::ALU_SRA:
            assert(dut->out == dut->src_a >> (dut->src_b & 31));
            break;
        case ALU_f::ALU_SRL:
            assert(dut->out == (unsigned)dut->src_a >> (dut->src_b & 31));
            break;
        }
        
    }

    delete dut;
    printf("SUCCESS\n");
    exit(EXIT_SUCCESS);
}
