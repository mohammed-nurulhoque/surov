TOOLCHAIN=/config/rv32i/
CC = $(TOOLCHAIN)/bin/riscv32-unknown-elf-gcc
OBJCOPY = $(TOOLCHAIN)/bin/riscv32-unknown-elf-objcopy
CFLAGS = -O2
LDFLAGS = -specs=nano.specs -Llib -lmylibc -lc_nano -lm -lgcc -nostdlib 
comp: $(SRC)
	$(CC) $(CFLAGS) $? $(LDFLAGS) -o $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin
