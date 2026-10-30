#!/bin/bash

verdi -sv \
    rtl/system_counter.sv \
    rtl/threshold_bank.sv \
    rtl/safety_checks.sv \
    rtl/status_logic.sv \
    rtl/replacement_control.sv \
    rtl/readback_logic.sv \
    rtl/tool_life_monitor_top.sv \
    tb/tb_tool_life_monitor.sv \
    +incdir+tb \
    -ssf sim/waves/tool_life_monitor.fsdb
