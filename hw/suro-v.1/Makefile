COMMON_SRCS = defs.sv rf.sv adder.sv shifter3.sv
CORE_SRCS = core_defs.sv alu3.sv datapath.sv control.sv cntrs.sv core.sv
SV_SRCS = $(addprefix ../common/,$(COMMON_SRCS)) $(CORE_SRCS)
CPP_TB = ../tests/test_surov.cpp
CFLAGS="-g -Og"
testbench: verilate $(SV_SRCS) $(CPP_TB)
	make -C obj_dir -f Vsurov.mk

verilate: synth $(SV_SRCS)
	verilator -CFLAGS $(CFLAGS) --cc --exe $(SV_SRCS) $(CPP_TB) --trace --trace-structs --top surov   -Wno-UNOPTFLAT

synth: $(SV_SRCS)
	sv2v $+ > suro.v

