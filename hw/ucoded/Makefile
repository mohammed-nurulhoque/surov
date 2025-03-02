core:
	verilator -cc --exe --trace testbench.cpp defs.sv alu.sv core.sv -Wno-CASEINCOMPLETE --top-module core
	make -C obj_dir/ -f Vcore.mk
run:
	obj_dir/Vcore ../../sw/bin/a.bin
