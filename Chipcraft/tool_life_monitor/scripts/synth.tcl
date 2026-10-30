# ============================================================
# Tool Life Monitor
# Synopsys Design Compiler Synthesis Script
# ============================================================


# ------------------------------------------------------------
# Project directories
# ------------------------------------------------------------

set RTL_DIR        "./rtl"
set CONSTRAINT_DIR "./constraints"
set NETLIST_DIR    "./netlist"
set REPORT_DIR     "./reports"

file mkdir $NETLIST_DIR
file mkdir $REPORT_DIR
file mkdir $REPORT_DIR/timing
file mkdir $REPORT_DIR/area
file mkdir $REPORT_DIR/power
file mkdir $REPORT_DIR/synthesis


# ------------------------------------------------------------
# Technology Library
# ------------------------------------------------------------

set TARGET_LIB \
"/home/prem5111/synopsys/dcs/syn/W-2024.09-SP5-3/doc/syn/dv_tutorial/risc_design/libs/core_typ.db"

set_app_var search_path [list . $RTL_DIR]

set_app_var target_library [list $TARGET_LIB]

set_app_var link_library \
"* $TARGET_LIB"


# ------------------------------------------------------------
# Read SystemVerilog RTL
# ------------------------------------------------------------

analyze -format sverilog {
    ./rtl/system_counter.sv
    ./rtl/threshold_bank.sv
    ./rtl/safety_checks.sv
    ./rtl/status_logic.sv
    ./rtl/replacement_control.sv
    ./rtl/readback_logic.sv
    ./rtl/tool_life_monitor_top.sv
}


# ------------------------------------------------------------
# Elaborate Top Module
# ------------------------------------------------------------

elaborate tool_life_monitor_top

current_design tool_life_monitor_top


# ------------------------------------------------------------
# Link Design
# ------------------------------------------------------------

link


# ------------------------------------------------------------
# Initial Design Check
# ------------------------------------------------------------

check_design \
    > ./reports/synthesis/check_design_pre.rpt


# ------------------------------------------------------------
# Apply Timing Constraints
# ------------------------------------------------------------

source ./constraints/tool_life_monitor.sdc


# ------------------------------------------------------------
# Check Timing Constraints
# ------------------------------------------------------------

check_timing \
    > ./reports/timing/check_timing_pre.rpt


# ------------------------------------------------------------
# Pre-Synthesis Reports
# ------------------------------------------------------------

report_clocks \
    > ./reports/timing/clocks.rpt

report_port \
    > ./reports/synthesis/ports.rpt


# ------------------------------------------------------------
# Synthesis and Optimization
# ------------------------------------------------------------

compile_ultra


# ------------------------------------------------------------
# Post-Synthesis Checks
# ------------------------------------------------------------

check_design \
    > ./reports/synthesis/check_design_post.rpt

check_timing \
    > ./reports/timing/check_timing_post.rpt


# ------------------------------------------------------------
# Timing Reports
# ------------------------------------------------------------

report_timing \
    -delay_type max \
    -max_paths 10 \
    > ./reports/timing/setup_timing.rpt

report_timing \
    -delay_type min \
    -max_paths 10 \
    > ./reports/timing/hold_timing.rpt


# ------------------------------------------------------------
# Area Report
# ------------------------------------------------------------

report_area -hierarchy \
    > ./reports/area/area.rpt


# ------------------------------------------------------------
# Power Report
# ------------------------------------------------------------

report_power \
    > ./reports/power/power.rpt


# ------------------------------------------------------------
# QoR Report
# ------------------------------------------------------------

report_qor \
    > ./reports/synthesis/qor.rpt


# ------------------------------------------------------------
# Resource Report
# ------------------------------------------------------------

report_resources \
    > ./reports/synthesis/resources.rpt


# ------------------------------------------------------------
# Cell Reference Report
# ------------------------------------------------------------

report_reference \
    > ./reports/synthesis/references.rpt


# ------------------------------------------------------------
# Clean Verilog Names
# ------------------------------------------------------------

change_names -rules verilog -hierarchy


# ------------------------------------------------------------
# Write Gate-Level Netlist
# ------------------------------------------------------------

write \
    -format verilog \
    -hierarchy \
    -output ./netlist/tool_life_monitor_syn.v


# ------------------------------------------------------------
# Write DDC
# ------------------------------------------------------------

write_file \
    -format ddc \
    -hierarchy \
    -output ./netlist/tool_life_monitor.ddc


# ------------------------------------------------------------
# Write Synthesized Constraints
# ------------------------------------------------------------

write_sdc \
    ./netlist/tool_life_monitor_syn.sdc


puts ""
puts "============================================================"
puts " TOOL LIFE MONITOR SYNTHESIS COMPLETED"
puts "============================================================"
puts ""
