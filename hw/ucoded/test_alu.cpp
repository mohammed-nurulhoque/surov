#include <filesystem>
#include <fstream>
#include <vector>

#include <cstdlib>
#include <cctype>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vshifter.h"
#include "Vshifter___024unit.h"

int main(int argc, char *argv[]) {
    Vshifter dut;
    int sim_time = 0;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut.trace(m_trace, 2);
    m_trace->open("waveform.vcd");
 
    int fails = 0;
    for (int i=0; i<100; i++) {
        int a = rand();
        int b = rand();
        int op = rand() % 8;
        dut.src_a = a;
        dut.src_b = b;
        dut.op = op;
        dut.eval();
        m_trace->dump(sim_time++);
        int expect;
        switch (op) {
            case ADDER_ADD:
                expect = a + b;
                break;
            case ADDER_SUB:
                expect = a - b;
                break;
            case ADDER_EQ:
                expect = a == b;
                break;
            case ADDER_NE:
                expect = a != b;
                break;
            case ADDER_LT:
                expect = a < b;
                break;
            case ADDER_GE:
                expect = a >= b;
                break;
            case ADDER_LTU:
                expect = (unsigned)a < (unsigned)b;
                break;
            case ADDER_GEU:
                expect = (unsigned)a >= (unsigned)b;
                break;
            default:
                printf("FAIL. Wrong OP\n");
                break;
        }
        if (dut.out != expect) {
            printf("%d (%d) %d, expected %d, got %d\n", a , op, b, expect, dut.out);
            fails++;
        }
    }

    m_trace->close();
    fprintf(stderr, "fails %f.\n", fails/(float)100);
    exit(EXIT_SUCCESS);
}
