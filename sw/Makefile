CC = riscv64-unknown-elf-gcc
OBJCOPY = riscv64-unknown-elf-objcopy
CFLAGS = march=rv32i 
LDFLAGS = -T lib/link.ld -lc -lm -lgcc -nostdlib 
comp: lib/crt0.S lib/semihost.c lib/semihost.S $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) $? -o $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf -o $(TARGET).bin
