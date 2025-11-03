REG_COUNT ?= 32
export REG_COUNT

comp:
	+make -C suro-v.2
	cp suro-v.2/obj_dir/Vsurov .

synth: suro.v
	./synth.sh | grep 'Chip area' -C25
	./sta.sh

suro.v:
	+make -C suro-v.2 synth
	cp suro-v.2/suro.v .

clean:
	+make -C suro-v.2 clean
	rm -f suro.v synth.v synth.json Vsurov

.PHONY: comp suro.v synth clean