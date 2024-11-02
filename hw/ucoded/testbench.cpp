#include <cstdlib>
#include <cctype>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vcore.h"
#include "Vcore___024unit.h"

enum mem_addr_t {
    MEM_B =  0b000,
    MEM_H =  0b001,
    MEM_W =  0b010,
    MEM_BU = 0b100,
    MEM_HU = 0b101
};

static const int RF_SIZE = 32;

void print_help(char *bin, int ecode) {
    printf("Usage %s [-i test-iters] [-h]\n", bin);
    exit(ecode);
}

class Memory {
    unsigned char *mem;
    unsigned size;

    union word_bytes {
        unsigned word;
        char bytes[4];
    };

    public:
    Memory(unsigned size)
        : size(size)
    {
        mem = new unsigned char[size];
        for (int i=0; i<size; i++)
            mem[i] = 0;
    }

    void flash(unsigned char *data, size_t len) {
        memcpy(mem, data, len);
    }

    void dump() {
        puts("Memory dump");
        for (int i=0; i<size; i++) {
            if (i%8==0) putc('\n', stdout);
            printf(" %02x:", mem[i]);
            if (isgraph(mem[i]))
                putc(mem[i], stdout);
            else
                putc('.', stdout);
        }
        putc('\n', stdout);
    }

    int load(unsigned addr, mem_addr_t addr_type, unsigned &output) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        printf("load %d@%d = ", addr_size, addr);
        if (addr + addr_size > size)
            return 1;
        word_bytes out {};
        for (unsigned i = 0; i < addr_size; i++) {
            out.bytes[i] = mem[addr+i];
        }
        switch (addr_type) {
        case MEM_B:
            out.word = (int32_t)(int8_t)out.word;
            break;
        case MEM_H:
            out.word = (int32_t)(int16_t)out.word;
            break;
        }
        printf("%x/%c\n", out.word, (char)out.word);
        output = out.word;
        return 0;
    }

    unsigned store(unsigned addr, unsigned val, mem_addr_t addr_type) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        printf("store %d@%d = %x\n", addr_size, addr, val);
        if (addr + addr_size > size)
            return 1;
        word_bytes val_bytes { .word = val };
        for (unsigned i = 0; i < (1 << addr_type); i++) {
            mem[addr+i] = val_bytes.bytes[i];
        }
        return 0;
    }
};


int main(int argc, char *argv[]) {
    Vcore dut;
    Memory dmem(50);
    int sim_time = 0;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut.trace(m_trace, 2);
    m_trace->open("waveform.vcd");

    unsigned char __attribute__((aligned(4))) test[] = {
    /* 0:*/ 0x03, 0x45, 0x40, 0x02,  // lbu a0, 0x24(zero)
    /* 4:*/ 0x63, 0x00, 0xc5, 0x01,  // beqz    a0, 0x4 <foo+0x4>
    /* 8:*/ 0x93, 0x05, 0x50, 0x02,  // li  a1, 0x25
    /* c:*/ 0x37, 0x06, 0x00, 0x08,  // lui a2, 0x8000
    /*10:*/ 0x23, 0x00, 0xa6, 0x00,  // sb  a0, 0x0(a2)
    /*14:*/ 0x03, 0xc5, 0x05, 0x00,  // lbu a0, 0x0(a1)
    /*18:*/ 0x93, 0x85, 0x15, 0x00,  // addi    a1, a1, 0x1
    /*1c:*/ 0xe3, 0x1a, 0x05, 0xfe,  // bnez    a0, 0x1c <.LBB0_2+0xc>
    /*20:*/ 0x73, 0x00, 0x10, 0x00,  // ebreak 
    	'H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd', '!', 0
    };

    dmem.flash(test, sizeof(test));

	uint32_t regfile[RF_SIZE];

    m_trace->dump(sim_time++);
    dut.rst = 1;
    dut.clk = 0;
    dut.eval();
    m_trace->dump(sim_time++);
    dut.clk = 1;
    dut.eval();
    m_trace->dump(sim_time++);
    dut.rst = 0;
 
    for (int i=0;; i++) {
        dut.clk = 0;
        dut.eval();
        // load
        if (!dut.mem_wren && dmem.load(dut.mem_addr, (mem_addr_t)dut.mem_size, dut.memread_data)) {
                m_trace->close();
                assert("load error" && false);
        }
        // store
        if (dut.mem_wren) {
            if (dut.mem_addr >= 0x8000000) {
                if (dut.mem_size == MEM_B)
                    printf("Output Char: %c\n", dut.memwrite_data);
                if (dut.mem_size == MEM_W & dut.memwrite_data == 0xffffffff) {
                    printf("Finished Simulation\n");
                    break;
                }
            }
            else if (dmem.store(dut.mem_addr, dut.memwrite_data, (mem_addr_t)(dut.mem_size))) {
                m_trace->close();
                assert("store error" && false);
            }
        }
        // RF read
        if (dut.regnum < RF_SIZE) {
            dut.rfread_data = dut.regnum ? regfile[dut.regnum] : 0;
        }
        dut.eval();
        m_trace->dump(sim_time++);
        // RF write
        if (dut.rf_wren && dut.regnum) {
            regfile[dut.regnum] = dut.rfwrite_data;
        }

        dut.eval();
        m_trace->dump(sim_time++);

        dut.clk = 1;
        dut.eval();
        m_trace->dump(sim_time++);
    }


    m_trace->close();
    printf("SUCCESS\n");
    dmem.dump();
    exit(EXIT_SUCCESS);
}
