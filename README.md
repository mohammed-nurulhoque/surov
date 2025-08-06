# suro-v

A tiny RISC-V processor that implements RV32I/E + Zicntr* + Zba. Uses a multi-cycle architecture where each instruction takes 2-4 cycles. Large shifts take additional cycles through a multi-stage shifter that can shift up to 3 bits per cycle. No interrupts or privilaged instructions.

Passes RISCV ISA tests rv32ui-p* and rv32uzba-p*.

Achives 0.498 DMIPS/MHz for I variant and 0.479 for E variant.

*Zicntr is basic cycle counter only - time returns cycle count, no higher-bit counters.

## Architecture

- **ISA**: RV32I + Zicntr (cycle counter only) + Zba. Fences are NOP.
- **Pipeline**: Multi-cycle, 2-4 cycles per instruction. Next instruction is prefetched during each instruction. 
- **Shifter**: Multi-stage, up to 3 bits per cycle. Right shifts take 1 extra cycle. All 3 kinds of shifts mux the same shifting circuit.
- **Adder** a single adder mux'ed for add/sub/compares, next pc calculation and load/store offsets. A separate adder shared between cycle/instret CSRs.

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

Quick PPA using openroad-flow-script nangate45.

| Config | DMIPS/MHz | Area (mm²/1000) | Freq (MHz)<sup>1</sup> | Power (mW) | DMIPS/MHz/mm2 | DMIPS/mm2 | DMIPS/W
|--------|-----------|-----------------|------------|------------|-----------| --- | ---
| suro-v i_zba | 0.498 | 14.96 | 618 | 41.6 | 33.3 | 20600 | 7400 |
| suro-v e_zba | 0.479 | 10.22 | 596 | 29.2 | 46.9 | 27900 | 9777 |
| suro-v e_zba latch_rf | 0.479 | 8.73 | 563 | 31.6 | 54.9 | 30900 | 8534 |
| VexRiscv<sup>2</sup>   | 0.82 | 24.34 | 794 | 71.2 | 33.7 | 26750 | 9140
| picorv32<sup>3</sup>  | < 0.516 | 21.4 | 849 | 94.2 | < 24.11 | < 20500 | < 4650
| picorv32e<sup>3</sup> | << 0.516 | 15.3 | 905 | 63.0 | << 33.7 | << 30500 | << 7412

<sup>1</sup> Freq is just 1/arrival time of wns path, with an unattainable timing target.

<sup>2</sup> VexRiscv min config from m-labs/VexRiscv-verilog.

<sup>3</sup> Comparable picorv32 config (ENABLE_COUNTERS64=0, CATCH_MISALIGN=0, CATCH_ILLINSN=0). The published 0.516 is for a core with barrel shifter, MUL and DIV, so the comparable core will have a lower score.

## How to Run

```
cd hw/

make # verilator simulator
./Vsurov <path-to-bin-file> [bin-start e.g. 0x1000] [exe-start-address e.g. 0x1008]

make synth # run yosys + sta
```

The Systemverilog source is in hw/suro-v.1. The makefile can be used from hw/ directly.

The verilator testbench is in hw/tests/test_surov.cpp. To accommodate for rv32e, it uses a5 for syscall number.

Note it doesn't support CSRs (except cssr (m)cycle / (m)time / (m)instret). The start-up code in many embedded toolchains includes such instructions. sw/lib has an alternative (just run make inside) libmylib.a which has startup code, printf without libc initialization and syscalls (number on a5).


