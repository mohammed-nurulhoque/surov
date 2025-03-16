    .global syscall0
    .global syscall1
    .global syscall2
    .global syscall3
syscall0:
syscall1:
syscall2:
syscall3:
    mv a7, a0
    mv a0, a1
    mv a1, a2
    mv a2, a3
    ecall
    ret

