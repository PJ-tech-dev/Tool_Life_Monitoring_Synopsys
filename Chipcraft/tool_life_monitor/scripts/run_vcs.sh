#!/bin/bash

mkdir -p sim/logs sim/waves

vcs -sverilog \
    -timescale=1ns/1ps \
    rtl/system_counter.sv \
    rtl/threshold_bank.sv \
    rtl/safety_checks.sv \
    rtl/status_logic.sv \
    rtl/replacement_control.sv \
    rtl/readback_logic.sv \
    rtl/tool_life_monitor_top.sv \
    tb/tb_tool_life_monitor.sv \
    +incdir+tb \
    -debug_access+all \
    -o simv \
    -l sim/logs/vcs_compile.log

if [ $? -eq 0 ]; then
    ./simv -l sim/logs/simulation.log
else
    echo "VCS compilation failed. Simulation not started."
    exit 1
fi
