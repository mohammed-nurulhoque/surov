TOOLCHAIN=/config/riscv/
CC = $(TOOLCHAIN)/bin/riscv32-unknown-elf-gcc
OBJCOPY = $(TOOLCHAIN)/bin/riscv32-unknown-elf-objcopy
CFLAGS = 
LDFLAGS = -specs=nano.specs -lc_nano -lm -lgcc -nostdlib 
comp: lib/* $(SRC)
	$(CC) $(CFLAGS) $? $(LDFLAGS) -o $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin
