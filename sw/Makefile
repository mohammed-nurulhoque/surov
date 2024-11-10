CC = riscv64-unknown-elf-gcc
CFLAGS = march=rv32i 
LDFLAGS = -T link.ld -lc -lm -lgcc -nostdlib 
comp: crt0.S semihost.c semihost.S $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) $?
