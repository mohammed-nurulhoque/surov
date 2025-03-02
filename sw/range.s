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

Disassembly of section .text:

0000000000000000 <.L3-0x8>:
   0:   00a05c63                blez    a0,18 <.L1>
   4:   00000793                li      a5,0

0000000000000008 <.L3>:
   8:   00f58733                add     a4,a1,a5
   c:   00f70023                sb      a5,0(a4)
  10:   00178793                addi    a5,a5,1
  14:   fef51ae3                bne     a0,a5,8 <.L3>

0000000000000018 <.L1>:
  18:   00100073                ebreak