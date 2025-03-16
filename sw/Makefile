TOOLCHAIN=/config/riscv/
CC = $(TOOLCHAIN)/bin/riscv32-unknown-elf-gcc
OBJCOPY = $(TOOLCHAIN)/bin/riscv32-unknown-elf-objcopy
CFLAGS = 
LDFLAGS = -lc -lm -lgcc -nostdlib 
comp: lib/crt0.S lib/semihost.c lib/semihost.S $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) $? -o $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin
