run-alu: obj_dir/Valu
	obj_dir/Valu

obj_dir/Valu: tests/alu.cpp obj_dir/Valu.h
	make -C obj_dir/ -f Valu.mk

obj_dir/Valu.h: common/alu.sv common/defs.sv
	verilator common/alu.sv -Icommon --cc --binary tests/alu.cpp -Wno-CASEINCOMPLETE

single-cycle: obj_dir/Vsingle_cycle
	obj_dir/Vsingle_cycle

obj_dir/Vsingle_cycle: tests/1c.cpp obj_dir/Vsingle_cycle.h
	make -C obj_dir -f Vsingle_cycle.mk

obj_dir/Vsingle_cycle.h: single_cycle.sv common/defs.sv common/alu.sv
	verilator --cc single_cycle.sv -Icommon -Wno-CASEINCOMPLETE -exe tests/1c.cpp --trace

COMMON_SRCS = defs.sv adder.sv shifter3.sv
SUROV_SRCS = core_defs.sv alu3.sv datapath.sv control.sv core.sv
suro-v.1: $(addprefix common/,$(COMMON_SRCS)) $(addprefix suro-v.1/,$(SUROV_SRCS)) tests/test_surov.cpp
	verilator --cc -Icommon $+ --trace --top core

suro.v: $(addprefix common/,$(COMMON_SRCS)) $(addprefix suro-v.1/,$(SUROV_SRCS))
	sv2v $+ > suro.v

