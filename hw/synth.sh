#!/bin/bash

# Defaults
VERILOG_FILE="${1:-suro.v}"
TOP_MODULE="${2:-surov}"
OUTPUT="${3:-synth}"
LIB_FILE="$(dirname "$(realpath "$0")")/lib/NangateOpenCellLibrary_typical.lib"

# Temporary Yosys script
YS_SCRIPT=$(mktemp --suffix .ys)

cat > "$YS_SCRIPT" <<EOF
# auto-generated yosys script
read_verilog $VERILOG_FILE
hierarchy -top $TOP_MODULE
flatten
synth

# map to Nangate45
dfflibmap -liberty $LIB_FILE
abc -liberty $LIB_FILE
clean

write_verilog $OUTPUT.v
write_json $OUTPUT.json
stat -liberty $LIB_FILE
EOF

echo "[INFO] Running synthesis for $VERILOG_FILE with top module $TOP_MODULE" >&2
yosys "$YS_SCRIPT"

rm "$YS_SCRIPT"