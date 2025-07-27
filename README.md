# r55: a RISC-V microprocessor

This is my attempt to learn microprocessor design. r55 is (will be) a 5-stage pipelined processor for the base RV32 ISA.

## Contents

`hw/ucoded` contains a simple microcoded cpu

 - rv32i_zifencei (no csr support)
 - 2 cycles (OP-IMM, LUI, AUIPC, JAL) to 4 cycles (BRANCH)
 - single-port register file
 - single adder
 - full barrel shifter

`hw/suro-v.1` is a rewrite of the above CPU with more modular code and some optimizations. It add zba extension.

![suro-v.1](surov.svg)

It uses a multistage shfiter which can shift upto 3 bits per cycle.

### How to run
```
cd hw/ucoded
make core
obj_dir/Vcore <path-to-bin-file> [bin-start e.g. 0x1000] [exe-start-address e.g. 0x1008]
```
The supplied sw/a.bin doesn't require the optional args above.

