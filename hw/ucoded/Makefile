core:
	verilator -cc --exe --trace testbench.cpp defs.sv alu.sv core.sv rfcore.sv -Wno-CASEINCOMPLETE --top-module rfcore
	make -C obj_dir/ -f Vrfcore.mk
run:
	obj_dir/Vcore ../../sw/bin/a.bin
