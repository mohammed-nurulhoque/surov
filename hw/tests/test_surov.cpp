#include <filesystem>
#include <fstream>
#include <vector>
#include <stdexcept>

#include <cstdlib>
#include <cctype>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vsurov.h"
#include "Vsurov_surov.h"
#include "Vsurov_datapath.h"
#include "Vsurov_cntrs.h"
#include "Vsurov_rf.h"

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

    unsigned load(unsigned addr, mem_addr_t addr_type) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        if (addr < start || (addr + addr_size > start + mem.size())) {
            std::ostringstream oss;
            oss << "Address 0x" << std::hex << addr << " is out of range";
            throw std::out_of_range(oss.str());
        }
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
        return out.word;
    }

    void store(unsigned addr, unsigned val, mem_addr_t addr_type) {
        unsigned addr_size = 1 << (addr_type & 0b11);
        if (addr + addr_size > start + mem.size()){
            std::ostringstream oss;
            oss << "Address 0x" << std::hex << addr << " is out of range";
            throw std::out_of_range(oss.str());
        }
        word_bytes val_bytes { .word = val };
        for (unsigned i = 0; i < (1 << addr_type); i++) {
            mem[addr-start+i] = val_bytes.bytes[i];
        }
    }
};


int main(int argc, char *argv[]) {
    if (argc < 2)
        assert("expect at least 1 argument" && false);
    Vsurov dut;
    size_t mem_start = 0;
    if (argc >= 3) {
        assert(sscanf(argv[2], "0x%lx", &mem_start) == 1);
    }
    size_t start_addr = mem_start;
    if (argc >= 4) {
        assert(sscanf(argv[3], "0x%lx", &start_addr) == 1);
    }
    const char *tracefile = nullptr;
    if (argc >= 5) {
        tracefile = argv[4];
    }
    std::ofstream trace_ofs;
    if (tracefile) {
        trace_ofs.open(tracefile);
        if (!trace_ofs.is_open()) {
            fprintf(stderr, "Failed to open tracefile: %s\n", tracefile);
            exit(EXIT_FAILURE);
        }
    }
    Memory dmem(4, mem_start);
    int sim_time = 0;
    int instr_count = 0;
    int result = EXIT_SUCCESS;

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
    while (1) {
        int regaddr_width = log2(REG_COUNT);
        auto ext_inst = [&](auto r) {
            return (r[3U] << (32-regaddr_width)) | (r[2U] >> regaddr_width);
        };
        auto ext_pc = [&](auto r) {
            return (r[4U] << (32-regaddr_width)) | (r[3U] >> regaddr_width);
        };

        unsigned pc = dut.surov->dp->pc;
        unsigned inst = dut.surov->dp->ir;

        if (dut.surov->cycle == 0) {
            instr_count++;
        }

        try {
            // load
            if (dut.mem_rden) {
                dut.memread_data = dmem.load(dut.mem_addr, (mem_addr_t)dut.mem_size);
#ifdef DEBUG
                fprintf(stderr, "LOAD pc: %08x addr: %08x size: %d val: %08x\n", pc, dut.mem_addr, 1<<(dut.mem_size &3), dut.memread_data);
#endif
            }
            // store
            if (dut.mem_wren) {
                dmem.store(dut.mem_addr, dut.memwrite_data, (mem_addr_t)(dut.mem_size));
#ifdef DEBUG
                fprintf(stderr, "STORE pc: %08x addr: %08x size: %d val: %08x\n", pc, dut.mem_addr, 1<<(dut.mem_size &3), dut.memwrite_data);
#endif
            }
        } catch (std::out_of_range &e) {
            fprintf(stderr, "Caught exception: %s\n", e.what());
            result = EXIT_FAILURE;
            goto END_SIM;
        }

        if (dut.trap) {
            auto& rf = dut.surov->r->regfile;
            int cycles = dut.surov->cn->counters[0];
            if (inst == 0x73) {// ecall
                switch (rf[rvreg::a5]) {
                    case Syscall::EXIT: {
                        unsigned exit_code = rf[rvreg::a0];
                        fprintf(stderr, "Completed %d instructions, %d cycles\n", instr_count, cycles);
                        fprintf(stderr, "EXIT STATUS: %d\n", exit_code);
                        result = exit_code;
                        goto END_SIM;
                    }
                    case Syscall::WRITE: {
                        unsigned address = rf[rvreg::a1];
                        unsigned nbytes = rf[rvreg::a2];
                        fprintf(stderr, "Trap at pc: %08x, cycle: %u _write(%d, %08x, %d)\n", pc, cycles, rf[rvreg::a0], address, nbytes);
                        dmem.print_str(address, nbytes);
                        break;
                    }
                    default: {
                        fprintf(stderr, "Unhandled trap #%d at pc: %08x, cycle: %u\n", rf[rvreg::a5], pc, cycles);
                        result = EXIT_FAILURE;
                        goto END_SIM;
                    }
                }
            } else if ((inst & 0x2073) == 0x2073) { // csrr(s)
            } else if (inst & 0x7f == 0b0001111) { // fence
            } else {
                fprintf(stderr, "Unrecognized OP_SYS #%08x at pc: %08x, cycle: %u\n", inst, pc, cycles);
                result = EXIT_FAILURE;
                goto END_SIM;
            }
        }
        dut.clk = 0;
        dut.eval();
        m_trace->dump(sim_time++);

        dut.clk = 1;
        dut.eval();
        m_trace->dump(sim_time++);

        if (sim_time > 10000000) {
            fprintf(stderr, "SIM TIMEOUT\n");
            result = EXIT_FAILURE;
        }
    }

END_SIM:
    m_trace->close();
    if (trace_ofs.is_open()) trace_ofs.close();
    // dmem.dump();
    return result;
}
