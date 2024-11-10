TOOLCHAIN = ~/Projects/llvm-project/install
CC = $(TOOLCHAIN)/bin/clang
CFLAGS = -I $(TOOLCHAIN)/riscv32-unknown-elf/include/ -I $(TOOLCHAIN)/lib/clang/19/include/ -march=rv32i 
LDFLAGS = -T link.ld -L $(TOOLCHAIN)/riscv32-unknown-elf/lib/ -L $(TOOLCHAIN)/lib/gcc/riscv32-unknown-elf/13.2.0/ -lc -lm -lgcc -nostdlib 
comp: crt0.S semihost.c semihost.S $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) $?
