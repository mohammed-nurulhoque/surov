#include <filesystem>
#include <fstream>
#include <vector>

#include <cstdlib>
#include <cctype>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vshifter.h"
#include "Vshifter___024unit.h"

enum op_t {
    SLL = 0,
    SRL = 1,
    SRA = 3
};

int main(int argc, char *argv[]) {
    Vshifter dut;
    int sim_time = 0;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut.trace(m_trace, 2);
    m_trace->open("waveform.vcd");
 
    int fails = 0;
    for (int i=0; i<2000; i++) {
        int a = rand();
        int b = rand() % 32;
        int op = rand() % 2;
        op = (op << 1) | (rand() % 2);
        if (op == 2) { i--; continue; }
        dut.val = a;
        dut.sham = b;
        dut.right_shift = op & 1;
        dut.arith_shift = op >> 1;
        dut.eval();
        m_trace->dump(sim_time++);
        int expect;
        switch (op) {
            case SLL:
                expect = a << (b & 31);
                break;
            case SRL:
                expect = (unsigned)a >> (b & 31);
                break;
            case SRA:
                expect = a >> (b & 31);
                break;
        }
        if (dut.out != expect) {
            printf("%d (%d) %d, expected %d, got %d\n", a , op, b, expect, dut.out);
            fails++;
        }
    }

    m_trace->close();
    fprintf(stderr, "fails %f\%.\n", (float)fails/2000*100);
    exit(EXIT_SUCCESS);
}
