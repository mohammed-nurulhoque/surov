COMMON_SRCS = defs.sv adder.sv shifter.sv
CORE_SRCS = core.sv rfcore.sv
SV_SRCS = $(addprefix ../common/,$(COMMON_SRCS)) $(CORE_SRCS)
CPP_TB = ../tests/testcore.cpp
CFLAGS="-g -Og"
DUT=rfcore
testbench: verilate $(SV_SRCS) $(CPP_TB)
	make -C obj_dir -f V$(DUT).mk

verilate: $(SV_SRCS)
	verilator -Wno-CASEINCOMPLETE -CFLAGS $(CFLAGS) --cc --exe $(SV_SRCS) $(CPP_TB) --trace --trace-structs --top $(DUT)

synth: sv2v
	yosys -p 'synth -top $(DUT); abc -g cmos2; stat' ucoded.v

sv2v: $(SV_SRCS)
	sv2v $+ --top $(DUT) > ucoded.v