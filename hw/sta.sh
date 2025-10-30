#!/bin/bash

# Defaults
VERILOG_FILE="${1:-synth.v}"
TOP_MODULE="${2:-surov}"
SDC_FILE="$(dirname "$0")/cpu.sdc"
LIB_FILE="$(dirname "$0")/lib/NangateOpenCellLibrary_typical.lib"

# Temporary STA script
STA_SCRIPT=$(mktemp --suffix .tcl)

cat > "$STA_SCRIPT" <<EOF
# auto-generated OpenSTA script
puts "Using verilog: $VERILOG_FILE"
puts "Top module: $TOP_MODULE"

read_liberty $LIB_FILE
read_verilog $VERILOG_FILE
link_design $TOP_MODULE
read_sdc $SDC_FILE

report_checks -path_delay min_max -fields {slew capacitance input_pin slew fanout} -digits 3
report_tns
report_wns
report_power
EOF

sta -exit "$STA_SCRIPT"

rm "$STA_SCRIPT"