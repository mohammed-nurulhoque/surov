    .section .start, "ax"
    .global _start
    .global __global_pointer
_start:
    .option push  
    .option norelax  
    la gp, __global_pointer$
    la sp, _end + 1024
    .option pop
    call main
    li a7, 93
    ecall
