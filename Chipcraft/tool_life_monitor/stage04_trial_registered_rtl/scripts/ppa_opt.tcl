# =====================================================================
# STAGE_04 // PPA OPTIMIZATION
# TOOL LIFE MONITOR
#
# Technology      : SAED 32nm
# Standard Cells  : RVT
# Setup Corner    : SS 0.95V 125C
# Hold Corner     : FF 1.16V -40C
# Clock           : 10 ns / 100 MHz
#
# Tool            : Synopsys Design Compiler
#
# Goal:
#   Optimize Power, Performance, and Area while preserving
#   functional behavior and satisfying the existing constraints.
# =====================================================================


# =====================================================================
# 1. PROJECT SETTINGS
# =====================================================================

set TOP            "tool_life_monitor_top"

set RTL_DIR        "./rtl"
set CONSTRAINT_DIR "./constraints"

set STAGE04_DIR    "./stage04"
set REPORT_DIR     "$STAGE04_DIR/reports"
set NETLIST_DIR    "$STAGE04_DIR/netlist"


# =====================================================================
# 2. CREATE OUTPUT DIRECTORIES
# =====================================================================

file mkdir $STAGE04_DIR

file mkdir $REPORT_DIR
file mkdir $REPORT_DIR/timing
file mkdir $REPORT_DIR/area
file mkdir $REPORT_DIR/power
file mkdir $REPORT_DIR/synthesis

file mkdir $NETLIST_DIR


# =====================================================================
# 3. SAED32 TIMING LIBRARIES
# =====================================================================

# Setup / maximum-delay library
set MAX_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ss0p95v125c.db"

# Hold / minimum-delay library
set MIN_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ff1p16vn40c.db"


# =====================================================================
# 4. VERIFY REQUIRED FILES
# =====================================================================

if {![file exists $MAX_LIB]} {
    puts "ERROR: Setup library not found:"
    puts "$MAX_LIB"
    exit 1
}

if {![file exists $MIN_LIB]} {
    puts "ERROR: Hold library not found:"
    puts "$MIN_LIB"
    exit 1
}

if {![file exists "$CONSTRAINT_DIR/tool_life_monitor.sdc"]} {
    puts "ERROR: SDC file not found:"
    puts "$CONSTRAINT_DIR/tool_life_monitor.sdc"
    exit 1
}


# =====================================================================
# 5. LIBRARY SETUP
# =====================================================================

set_app_var search_path [list . $RTL_DIR]

set_app_var target_library [list $MAX_LIB]

set_app_var link_library "* $MAX_LIB $MIN_LIB"

# Associate setup and hold PVT libraries.
set_min_library $MAX_LIB \
    -min_version $MIN_LIB


# =====================================================================
# 6. READ RTL
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE 04 : ANALYZING RTL"
puts "================================================================="
puts ""

analyze -format sverilog {
    ./rtl/system_counter.sv
    ./rtl/threshold_bank.sv
    ./rtl/safety_checks.sv
    ./rtl/status_logic.sv
    ./rtl/replacement_control.sv
    ./rtl/readback_logic.sv
    ./rtl/tool_life_monitor_top.sv
}


# =====================================================================
# 7. ELABORATE DESIGN
# =====================================================================

elaborate $TOP

current_design $TOP


# =====================================================================
# 8. LINK DESIGN
# =====================================================================

link


# =====================================================================
# 9. PRE-OPTIMIZATION DESIGN CHECK
# =====================================================================

redirect -file $REPORT_DIR/synthesis/check_design_pre.rpt {
    check_design
}


# =====================================================================
# 10. APPLY SAME CONSTRAINTS AS BASELINE
# =====================================================================

source $CONSTRAINT_DIR/tool_life_monitor.sdc


# =====================================================================
# 11. PRE-OPTIMIZATION TIMING CHECK
# =====================================================================

redirect -file $REPORT_DIR/timing/check_timing_pre.rpt {
    check_timing
}

redirect -file $REPORT_DIR/timing/clocks.rpt {
    report_clocks
}


# =====================================================================
# 12. PPA OPTIMIZATION - PASS 1
#
# set_max_area 0 asks DC to minimize area as far as possible while
# satisfying higher-priority timing/design constraints.
#
# compile_ultra performs timing/area optimization and Power Compiler
# performs leakage-power optimization when available.
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE 04 : PPA OPTIMIZATION PASS 1"
puts "================================================================="
puts ""

set_max_area 0

compile_ultra -area_high_effort_script


# =====================================================================
# 13. HOLD OPTIMIZATION
#
# Baseline synthesis showed short minimum-delay paths.
# Request DC to repair hold paths for CLK.
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE 04 : HOLD OPTIMIZATION"
puts "================================================================="
puts ""

set_fix_hold [get_clocks CLK]


# =====================================================================
# 14. PPA OPTIMIZATION - INCREMENTAL PASS
#
# Incrementally optimize the mapped design after requesting hold fixes.
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE 04 : INCREMENTAL OPTIMIZATION"
puts "================================================================="
puts ""

compile_ultra -incremental


# =====================================================================
# 15. FINAL DESIGN CHECK
# =====================================================================

redirect -file $REPORT_DIR/synthesis/check_design.rpt {
    check_design
}


# =====================================================================
# 16. FINAL TIMING CHECK
# =====================================================================

redirect -file $REPORT_DIR/timing/check_timing.rpt {
    check_timing
}


# =====================================================================
# 17. FINAL SETUP TIMING REPORT
# =====================================================================

redirect -file $REPORT_DIR/timing/setup_timing.rpt {
    report_timing \
        -delay_type max \
        -max_paths 20 \
        -path full
}


# =====================================================================
# 18. FINAL HOLD TIMING REPORT
# =====================================================================

redirect -file $REPORT_DIR/timing/hold_timing.rpt {
    report_timing \
        -delay_type min \
        -max_paths 20 \
        -path full
}


# =====================================================================
# 19. CONSTRAINT VIOLATIONS
# =====================================================================

redirect -file $REPORT_DIR/timing/constraints.rpt {
    report_constraint -all_violators
}


# =====================================================================
# 20. AREA REPORT
# =====================================================================

redirect -file $REPORT_DIR/area/area.rpt {
    report_area -hierarchy
}


# =====================================================================
# 21. POWER REPORT
# =====================================================================

redirect -file $REPORT_DIR/power/power.rpt {
    report_power
}


# =====================================================================
# 22. QUALITY OF RESULTS
# =====================================================================

redirect -file $REPORT_DIR/synthesis/qor.rpt {
    report_qor
}


# =====================================================================
# 23. CELL REFERENCES
# =====================================================================

redirect -file $REPORT_DIR/synthesis/references.rpt {
    report_reference
}


# =====================================================================
# 24. RESOURCE REPORT
# =====================================================================

redirect -file $REPORT_DIR/synthesis/resources.rpt {
    report_resources
}


# =====================================================================
# 25. FINAL CLOCK REPORT
# =====================================================================

redirect -file $REPORT_DIR/timing/clocks_final.rpt {
    report_clocks
}


# =====================================================================
# 26. CLEAN NAMES FOR GATE-LEVEL VERILOG
# =====================================================================

change_names -rules verilog -hierarchy


# =====================================================================
# 27. WRITE OPTIMIZED GATE-LEVEL NETLIST
#
# THIS IS THE PRIMARY STAGE 04 DELIVERABLE.
# =====================================================================

write \
    -format verilog \
    -hierarchy \
    -output $NETLIST_DIR/tool_life_monitor_ppa_opt.v


# =====================================================================
# 28. WRITE OPTIMIZED DDC
# =====================================================================

write_file \
    -format ddc \
    -hierarchy \
    -output $NETLIST_DIR/tool_life_monitor_ppa_opt.ddc


# =====================================================================
# 29. WRITE FINAL CONSTRAINTS
# =====================================================================

write_sdc \
    $NETLIST_DIR/tool_life_monitor_ppa_opt.sdc


# =====================================================================
# 30. COMPLETION MESSAGE
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE_04 // PPA OPTIMIZATION COMPLETED"
puts "================================================================="
puts " Technology      : SAED 32nm"
puts " Cell Family     : RVT"
puts " Setup Corner    : SS 0.95V 125C"
puts " Hold Corner     : FF 1.16V -40C"
puts " Clock           : 10 ns / 100 MHz"
puts ""
puts " Optimized Gate-Level Netlist:"
puts " $NETLIST_DIR/tool_life_monitor_ppa_opt.v"
puts ""
puts " Timing Reports:"
puts " $REPORT_DIR/timing/setup_timing.rpt"
puts " $REPORT_DIR/timing/hold_timing.rpt"
puts " $REPORT_DIR/timing/constraints.rpt"
puts ""
puts " PPA Reports:"
puts " $REPORT_DIR/area/area.rpt"
puts " $REPORT_DIR/power/power.rpt"
puts " $REPORT_DIR/synthesis/qor.rpt"
puts "================================================================="
puts ""

exit
