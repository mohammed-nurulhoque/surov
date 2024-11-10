#include <filesystem>
#include <fstream>
#include <vector>

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

static const char *regname[] = {
    "zero", "ra", "sp", "gp",
    "tp", "t0", "t1", "t2",
    "s0", "s1",
    "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", 
    "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11", 
    "t3", "t4", "t5", "t6" 
};

void print_help(char *bin, int ecode) {
    printf("Usage %s [-i test-iters] [-h]\n", bin);
    exit(ecode);
}

class Memory {
    std::vector<char> mem;

    union word_bytes {
        unsigned word;
        char bytes[4];
    };

    public:
    Memory(unsigned size)
        : mem(size, 0) {}

    void flash(unsigned char *data, size_t len) {
        mem.resize(len);
        memcpy(&mem[0], data, len);
    }

    void flash(char *filename, size_t minsize=0) {
        size_t fsize = std::filesystem::file_size(filename);
        mem.resize(std::max(fsize+4, minsize)); // hack because last instruction might fetch next
        std::ifstream f(filename, std::ios::binary);
        f.read(&mem[0], fsize);
    }

    void dump() {
        fputs("Memory dump", stderr);
        for (int i=0; i<mem.size(); i++) {
            if (i%8==0) putc('\n', stderr);
            fprintf(stderr, " %02x:", mem[i]);
            if (isgraph(mem[i]))
                putc(mem[i], stderr);
            else
                putc('.', stderr);
        }
        putc('\n', stderr);
    }

    int load(unsigned addr, mem_addr_t addr_type, unsigned &output) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        fprintf(stderr, "load %d@%x = ", addr_size, addr);
        if (addr + addr_size > mem.size())
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
        fprintf(stderr, "%x/%c\n", out.word, (char)out.word);
        output = out.word;
        return 0;
    }

    unsigned store(unsigned addr, unsigned val, mem_addr_t addr_type) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        fprintf(stderr, "store %d@%x = %x\n", addr_size, addr, val);
        if (addr + addr_size > mem.size())
            return 1;
        word_bytes val_bytes { .word = val };
        for (unsigned i = 0; i < (1 << addr_type); i++) {
            mem[addr+i] = val_bytes.bytes[i];
        }
        return 0;
    }
};


int main(int argc, char *argv[]) {
    if (argc != 2)
        assert("expert 1 argument" && false);
    Vcore dut;
    Memory dmem(50);
    int sim_time = 0;
    int instr_count = 0;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut.trace(m_trace, 2);
    m_trace->open("waveform.vcd");

    dmem.flash(argv[1], 0x800);

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
        if (dut.cycle == 0)
            instr_count++;
        // load
        if (dut.mem_read && dmem.load(dut.mem_addr, (mem_addr_t)dut.mem_size, dut.memread_data)) {
                m_trace->close();
                assert("load error" && false);
        }
        // store
        if (dut.mem_wren) {
            if (dut.mem_addr >= 0x8000000) {
                if (dut.mem_size == MEM_B) {
                    putc(dut.memwrite_data, stdout);
                    fprintf(stderr, "wrote byte %c\n", (char)dut.memwrite_data);
                } else if (dut.mem_size == MEM_W & dut.memwrite_data == 0xffffffff) {
                    fprintf(stderr, "Finished Simulation\n");
                    break;
                }
            }
            else if (dmem.store(dut.mem_addr, dut.memwrite_data, (mem_addr_t)(dut.mem_size))) {
                m_trace->close();
                assert("store error" && false);
            }
        }
        // RF read
        if (dut.rf_read) {
            assert(dut.regnum < RF_SIZE && "invalid regnum");
            dut.rfread_data = regfile[dut.regnum];
            fprintf(stderr, "read %s = %x\n", regname[dut.regnum], regfile[dut.regnum]);
        }
        dut.eval();
        m_trace->dump(sim_time++);
        // RF write
        if (dut.rf_wren && dut.regnum) {
            fprintf(stderr, "write %s = %x\n", regname[dut.regnum], dut.rfwrite_data);
            regfile[dut.regnum] = dut.rfwrite_data;
        }

        dut.eval();
        m_trace->dump(sim_time++);

        dut.clk = 1;
        dut.eval();
        m_trace->dump(sim_time++);
    }


    m_trace->close();
    fprintf(stderr, "SUCCESS. Completed %d instructions, %d cycles\n", instr_count, sim_time/3-1);
    // dmem.dump();
    exit(EXIT_SUCCESS);
}
