#include <filesystem>
#include <fstream>
#include <vector>

#include <cstdlib>
#include <cctype>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vrfcore.h"
#include "Vrfcore___024root.h"
#include "Vrfcore_rfcore.h"
#include "Vrfcore_core.h"

enum mem_addr_t {
    MEM_B =  0b000,
    MEM_H =  0b001,
    MEM_W =  0b010,
    MEM_BU = 0b100,
    MEM_HU = 0b101
};

enum rvreg {
    zero, ra, sp, gp,
    tp, t0, t1, t2,
    s0, s1,
    a0, a1, a2, a3, a4, a5, a6, a7, 
    s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, 
    t3, t4, t5, t6 
};

enum Syscall {
    READ = 63,
    WRITE = 64,
    EXIT = 93
};

void print_help(char *bin, int ecode) {
    printf("Usage %s [-i test-iters] [-h]\n", bin);
    exit(ecode);
}

class Memory {
    std::vector<char> mem;
    size_t start;

    union word_bytes {
        unsigned word;
        char bytes[4];
    };

    public:
    Memory(unsigned size, size_t start=0)
        : mem(size, 0), start(start) {}

    void flash(char *filename, size_t stacksize=1024) {
        size_t fsize = std::filesystem::file_size(filename);
        mem.resize(fsize + stacksize);
        std::ifstream f(filename, std::ios::binary);
        f.read(&mem[0], fsize);
    }

    void print_str(unsigned addr, unsigned nbytes) {
        fwrite(&mem[addr-start], nbytes, 1, stdout);
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
        if (addr + addr_size > start + mem.size())
            return 1;
        word_bytes out {};
        for (unsigned i = 0; i < addr_size; i++) {
            out.bytes[i] = mem[addr-start+i];
        }
        switch (addr_type) {
        case MEM_B:
            out.word = (int32_t)(int8_t)out.word;
            break;
        case MEM_H:
            out.word = (int32_t)(int16_t)out.word;
            break;
        }
        output = out.word;
        return 0;
    }

    unsigned store(unsigned addr, unsigned val, mem_addr_t addr_type) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        if (addr + addr_size > start + mem.size())
            return 1;
        word_bytes val_bytes { .word = val };
        for (unsigned i = 0; i < (1 << addr_type); i++) {
            mem[addr-start+i] = val_bytes.bytes[i];
        }
        return 0;
    }
};


int main(int argc, char *argv[]) {
    if (argc < 2)
        assert("expert 1 argument" && false);
    Vrfcore dut;
    size_t mem_start = 0;
    if (argc >= 3) {
        assert(sscanf(argv[2], "0x%lx", &mem_start) == 1);
    }
    size_t start_addr = mem_start;
    if (argc >= 4) {
	    assert(sscanf(argv[3], "0x%lx", &start_addr) == 1);
    }
    Memory dmem(4, mem_start);
    int sim_time = 0;
    int instr_count = 0;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut.trace(m_trace, 2);
    m_trace->open("waveform.vcd");

    dmem.flash(argv[1], 0x3000);

    m_trace->dump(sim_time++);
    dut.rst = 1;
    dut.memread_data = start_addr;
    dut.clk = 0;
    dut.eval();
    m_trace->dump(sim_time++);
    dut.clk = 1;
    dut.eval();
    m_trace->dump(sim_time++);
    dut.rst = 0;
    dut.clk = 0;
    dut.eval();
    m_trace->dump(sim_time++);
    for (int i=0;; i++) {
        if (dut.rfcore->c->cycle == 0) {instr_count++;}
        
        // load
        if (dut.mem_read && dmem.load(dut.mem_addr, (mem_addr_t)dut.mem_size, dut.memread_data)) {
                m_trace->close();
                assert("load error" && false);
        }
        // store
        if (dut.mem_wren && dmem.store(dut.mem_addr, dut.memwrite_data, (mem_addr_t)(dut.mem_size))) {
            m_trace->close();
            assert("store error" && false);
        }

        if (dut.host_trap) {
            unsigned inst = dut.rfcore->c->inst;
            if (inst == 0x73) {// ecall
                switch (dut.rfcore->regfile[rvreg::a7]) {
                    case Syscall::EXIT:
                        goto END_SIM;
                    case Syscall::WRITE: {
                        unsigned address = dut.rfcore->regfile[rvreg::a1];
                        unsigned nbytes = dut.rfcore->regfile[rvreg::a2];
                        dmem.print_str(address, nbytes);
                    }
                }
            } else if ((inst & 0xC0002073) == 0xC0002073) { // rdcycle
                dut.rfcore->regfile[(inst >> 7) & 31] = sim_time/2;
            }
        }
        dut.clk = 0;
        dut.eval();
        m_trace->dump(sim_time++);

        dut.clk = 1;
        dut.eval();
        m_trace->dump(sim_time++);
    }

END_SIM:
    m_trace->close();
    fprintf(stderr, "%d SUCCESS. Completed %d instructions, %d cycles\n", dut.rfcore->regfile[rvreg::a0], instr_count, sim_time/2-1);
    // dmem.dump();
    exit(EXIT_SUCCESS);
}
