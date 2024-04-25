#include <cstdlib>
#include <iostream>
#include <ctime>
#include <cctype>
#include <vector>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vsingle_cycle.h"
#include "Vsingle_cycle___024unit.h"

enum mem_addr_t {
    MEM_B =  0b000,
    MEM_H =  0b001,
    MEM_W =  0b010,
    MEM_BU = 0b100,
    MEM_HU = 0b101
};

void print_help(char *bin, int ecode) {
    printf("Usage %s [-i test-iters] [-h]\n", bin);
    exit(ecode);
}

class Memory {
    char *mem;
    unsigned size;

    union word_bytes {
        unsigned word;
        char bytes[4];
    };

    public:
    Memory(unsigned size)
        : size(size)
    {
        mem = new char[size];
        for (int i=0; i<size; i++)
            mem[i] = 0;
    }

    void flash(char *data, size_t len) {
        memcpy(mem, data, len);
    }

    void dump() {
        puts("Memory dump");
        for (int i=0; i<size; i++) {
            printf(" %02x:", mem[i]);
            if (isgraph(mem[i]))
                putc(mem[i], stdout);
            else
                putc('.', stdout);
            if (i%8==0) putc('\n', stdout);
        }
    }

    int load(unsigned addr, mem_addr_t addr_type, unsigned &output) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        if (addr + addr_size > size)
            return 1;
        word_bytes out;
        for (unsigned i = 0; i < addr_size; i++) {
            out.bytes[i] = mem[i];
        }
        printf("load %d@%d = %d\n", addr_size, addr, out.word);
        output = out.word;
        return 0;
    }

    unsigned store(unsigned addr, unsigned val, mem_addr_t addr_type) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        printf("store %d@%d = %d\n", addr_size, addr, val);
        if (addr + addr_size > size)
            return 1;
        word_bytes val_bytes { .word = val };
        for (unsigned i = 0; i < (1 << addr_type); i++) {
            mem[i] = val_bytes.bytes[i];
        }
        return 0;
    }
};


int main(int argc, char *argv[]) {
    Vsingle_cycle dut;
    Memory dmem(32);
    unsigned regfile[32];
    regfile[0] = 0;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut.trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    unsigned char __attribute__((aligned(4))) test[] = {
        0x03, 0x45, 0x00, 0x00,  // lbu a0, 0(zero)
        0x63, 0x02, 0x05, 0x02,  // beqz    a0, 0x28 <test+0x28>
        0x13, 0x05, 0x10, 0x00,  // li  a0, 1  <-- src
        0x93, 0x05, 0x00, 0x01,  // li  a1, 16 <-- dst
        0x03, 0x46, 0xf5, 0xff,  // lbu a2, -1(a0)
        0x23, 0x80, 0xc5, 0x00,  // sb  a2, 0(a1)
        0x03, 0x46, 0x05, 0x00,  // lbu a2, 0(a0)
        0x13, 0x05, 0x15, 0x00,  // addi    a0, a0, 1
        0x93, 0x85, 0x15, 0x00,  // addi    a1, a1, 1
        0xe3, 0x16, 0x06, 0xfe,  // bnez    a2, 0x10 <test+0x10>
     // 0x67, 0x80, 0x00, 0x00   // ret
    };

    char ram[] = "Hello World!";
    dmem.flash(ram, sizeof(ram));

    dut.rst = 1;
    dut.clk = 0;
    dut.eval();
    dut.clk = 1;
    dut.eval();
    dut.rst = 0;
 
    for (int i=0;; i++) {
        dut.clk = 0;
        dut.inst = ((unsigned *)test)[dut.pc/4];
        printf("pc:%08x, inst:%08x\n", dut.pc, dut.inst);
        if (dut.pc == sizeof(test)) break;
        dut.eval();
        dut.rs1val = regfile[dut.rs1];
        dut.rs2val = regfile[dut.rs2];
        dut.eval();
        if (dut.dmem_rd && dmem.load(dut.dmem_addr, (mem_addr_t)dut.dmem_size, dut.dmem_data)) {
                m_trace->close();
                assert(false);
        }
        printf("dmem data: %x\n", dut.dmem_data);
        dut.eval();
        dut.dmem_in_enable = dut.dmem_rd;
        printf("dmem data: %x\n", dut.dmem_data);
        m_trace->dump(i*2);
        if (dut.wr_reg && dut.rd != 0)
            regfile[dut.rd] = dut.rdval;
        if (dut.dmem_wr && dmem.store(dut.dmem_addr, dut.dmem_data, (mem_addr_t)dut.dmem_size)) {
                m_trace->close();
                assert(false);
        }

        dut.clk = 1;
        dut.eval();
        m_trace->dump(i*2+1);
    }


    m_trace->close();
    printf("SUCCESS\n");
    exit(EXIT_SUCCESS);
}
