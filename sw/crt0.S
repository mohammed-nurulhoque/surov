    .section .start, "ax"
    .global _start
    .global _sp_start
_start:
    addi sp, zero, 0x7fc
    call main
    ebreak
