# r55: a RISC-V microprocessor

This is my attempt to learn microprocessor design. r55 is (will be) a 5-stage pipelined processor for the base RV32 ISA.

## microcode CPU

`hw/ucoded` contains a simple microcoded cpu

 - 2 cycles (OP-IMM, LUI, AUIPC, JAL) to 4 cycles (BRANCH)
 - single-port register file
 - single adder
 - full barrel shifter

 The testbench hw/testbench.cpp defined 0x8000000 as a special memory-mapped IO address.
 So far tested to work with a simple hello world loop test.
