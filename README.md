# suro-v

A tiny RISC-V processor that implements RV32I + Zicntr* + Zba. Uses a multi-cycle architecture where each instruction takes 2-4 cycles. Large shifts take additional cycles through a multi-stage shifter that can shift up to 3 bits per cycle.

*Zicntr is basic cycle counter only - time returns cycle count, no higher performance counters.

## Architecture

- **ISA**: RV32I + Zicntr (cycle counter only) + Zba
- **Design**: Multi-cycle, 2-4 cycles per instruction
- **Shifter**: Multi-stage, up to 3 bits per cycle

### Instruction Timing

| Operation Type | Cycles |
|----------------|--------|
| ALU (reg-reg)  | 3      |
| ALU (reg-imm)  | 2      |
| Load/Store     | 3      |
| Branches       | 4      |
| JAL            | 2      |
| JALR           | 3      |

![suro-v Architecture](surov.svg)

## Performance

Quick PPA using OpenSTA with 45nm NAND process. No place & route.

| Config | DMIPS/MHz | Area (mm²/1000) | Freq (MHz) | Power (mW) | Perf/Area |
|--------|-----------|-----------------|------------|------------|-----------|
| suro-v i_zba | 0.50 | 10.8 | 177 | 7.54 | 46 |
| suro-v e_zba | 0.48 | 7.0 | 188 | 5.56 | 69 |
| picorv32* | 0.52 | 27.5 | 113 | 9.99 | 19 |
| picorv32** | ? | 13.8 | 229 | 5.45 | ?<38 |

*Published picorv32 Dhrystone results  
**Comparable picorv32 config (ENABLE_COUNTERS64=0, ENABLE_REGS_DUALPORT=0, CATCH_MISALIGN=0, CATCH_ILLINSN=0)

Not bad for a first serious CPU design and solo effort. The stripped-down picorv32 is much closer in area (still 28% larger though), but suro-v holds its own on performance density. The RV32E version does particularly well - nearly 70 DMIPS/MHz per mm².

## Why Multi-Cycle?

 Multi-cycle designs can be really area efficient. Each functional unit gets used multiple times per instruction, so you need fewer of them. Plus shorter critical paths = higher frequency on the same process.

Trade-off is obvious - lower IPC. But for a lot of embedded stuff, the area/power savings are worth it.

# How to Run

```
cd hw/

make # verilator simulator
./Vsurov <path-to-bin-file> [bin-start e.g. 0x1000] [exe-start-address e.g. 0x1008]

make synth # run yosys + sta
```

The Systemverilog source is in hw/suro-v.1. The makefile can be used from hw/ directly.

The verilator testbench is in hw/tests/test_surov.cpp. To accommodate for rv32e, it uses a5 for syscall number.

Note it doesn't support CSRs (except cssr (m)cycle / (m)time / (m)instret). The start-up code in many embedded toolchains includes such instructions. sw/lib has an alternative (just run make inside) libmylib.a which has startup code, printf without libc initialization and syscalls (number on a5).


