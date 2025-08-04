REG_COUNT ?= 32
export REG_COUNT

comp:
	+make -C suro-v.1
	cp suro-v.1/obj_dir/Vsurov .

synth:
	+make -C suro-v.1 synth
	cp suro-v.1/suro.v .
	./synth.sh | grep 'Chip area' -C25
	./sta.sh 

clean:
	+make -C suro-v.1 clean
	rm -f suro.v synth.v synth.json Vsurov

.PHONY: comp synth clean