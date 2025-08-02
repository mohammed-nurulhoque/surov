# Variables
TOOLCHAIN_PREFIX = ~/riscv-gcc/bin/riscv64-unknown-elf-
CC = $(TOOLCHAIN_PREFIX)gcc
AR = $(TOOLCHAIN_PREFIX)ar
ARCH=rv32i_zba
ABI=ilp32
CFLAGS = -O2 -march=$(ARCH) -mabi=$(ABI)

# Directories
OBJDIR = obj

# Source files
SOURCES = $(wildcard *.c *.S)
OBJECTS = $(SOURCES:%=$(OBJDIR)/%.o)

# Target library
LIBNAME = libmylib.a

# Default target
all: $(LIBNAME)

# Create object directory
$(OBJDIR):
	mkdir -p $(OBJDIR)

# Compile source files (C and assembly)
$(OBJDIR)/%.o: % | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Create static library
$(LIBNAME): $(OBJECTS)
	$(AR) rcs $@ $^

# Clean targets
clean:
	rm -rf $(OBJDIR) $(LIBNAME)

.PHONY: all clean