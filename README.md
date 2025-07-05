# r55: a RISC-V microprocessor

This is my attempt to learn microprocessor design. r55 is (will be) a 5-stage pipelined processor for the base RV32 ISA.

## microcode CPU

`hw/ucoded` contains a simple microcoded cpu

 - rv32i_zifencei (no csr support)
 - 2 cycles (OP-IMM, LUI, AUIPC, JAL) to 4 cycles (BRANCH)
 - single-port register file
 - single adder
 - full barrel shifter

 The testbench hw/testbench.cpp defined 0x8000000 as a special memory-mapped IO address.
 So far tested to run some small tests and most of riscv-tests.

### How to run
```
cd hw/ucoded
make core run
obj_dir/Vcore <path-to-bin-file> [bin-start e.g. 0x1000] [exe-start-address e.g. 0x1008]
```
The supplied sw/a.bin doesn't require the optional args above.

