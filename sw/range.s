        .text
        blez    a0,.L1
        li      a5,0
.L3:
        add     a4,a1,a5
        sb      a5,0(a4)
        addi    a5,a5,1
        bne     a0,a5,.L3
.L1:
        ebreak