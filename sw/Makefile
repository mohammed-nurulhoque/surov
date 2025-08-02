TOOLCHAIN=/config/riscv-gcc/
CC = $(TOOLCHAIN)/bin/riscv64-unknown-elf-gcc
OBJCOPY = $(TOOLCHAIN)/bin/riscv64-unknown-elf-objcopy
ARCH=rv32i_zba
ABI=ilp32
CFLAGS = -O2 -march=$(ARCH) -mabi=$(ABI)
LDFLAGS = -specs=nano.specs -Llib -lmylibc -lc_nano -lm -lgcc -nostdlib

# Directories
LIBDIR = lib
OBJDIR = obj

comp: $(SRC)
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $? $(LDFLAGS) -o $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin
