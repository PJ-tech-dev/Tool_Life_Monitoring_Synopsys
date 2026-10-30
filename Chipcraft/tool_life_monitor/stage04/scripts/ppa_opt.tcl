# =====================================================================
# STAGE_04 // PPA OPTIMIZATION - V2
# TOOL LIFE MONITOR
#
# Technology      : SAED 32nm
# Standard Cells  : RVT
# Setup Corner    : SS 0.95V 125C
# Min/Hold Corner : FF 1.16V -40C
# Clock           : 10 ns / 100 MHz
#
# Tool            : Synopsys Design Compiler
#
# Strategy:
#   1. Synthesize verified baseline RTL
#   2. compile_ultra
#   3. optimize_netlist -area
#   4. Report final PPA/timing
#   5. Write optimized gate-level netlist
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
# 3. SAED32 LIBRARIES
# =====================================================================

set MAX_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ss0p95v125c.db"

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
    puts "ERROR: Constraint file not found:"
    puts "$CONSTRAINT_DIR/tool_life_monitor.sdc"
    exit 1
}


# =====================================================================
# 5. DESIGN COMPILER LIBRARY SETUP
# =====================================================================

set_app_var search_path [list . $RTL_DIR]

set_app_var target_library [list $MAX_LIB]

set_app_var link_library "* $MAX_LIB $MIN_LIB"

set_min_library $MAX_LIB \
    -min_version $MIN_LIB


# =====================================================================
# 6. ANALYZE VERIFIED RTL
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE 04 : ANALYZING VERIFIED RTL"
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
# 7. ELABORATE
# =====================================================================

elaborate $TOP

current_design $TOP


# =====================================================================
# 8. LINK
# =====================================================================

link


# =====================================================================
# 9. PRE-OPTIMIZATION DESIGN CHECK
# =====================================================================

redirect -file $REPORT_DIR/synthesis/check_design_pre.rpt {
    check_design
}

redirect -file $REPORT_DIR/synthesis/resources_pre.rpt {
    report_resources
}


# =====================================================================
# 10. APPLY CONSTRAINTS
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
# 12. PRIMARY PPA SYNTHESIS
#
# compile_ultra performs high-effort timing/area mapping.
# DC also performs leakage-power optimization where applicable.
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE 04 : COMPILE_ULTRA"
puts "================================================================="
puts ""

compile_ultra


# =====================================================================
# 13. POST-MAPPING AREA OPTIMIZATION
#
# DC W-2024.09 explicitly recommends optimize_netlist -area instead
# of the deprecated/ignored -area_high_effort_script option.
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE 04 : OPTIMIZE_NETLIST -AREA"
puts "================================================================="
puts ""

optimize_netlist -area


# =====================================================================
# 14. FINAL DESIGN CHECK
# =====================================================================

redirect -file $REPORT_DIR/synthesis/check_design.rpt {
    check_design
}


# =====================================================================
# 15. FINAL TIMING CHECK
# =====================================================================

redirect -file $REPORT_DIR/timing/check_timing.rpt {
    check_timing
}


# =====================================================================
# 16. SETUP TIMING
# =====================================================================

redirect -file $REPORT_DIR/timing/setup_timing.rpt {
    report_timing \
        -delay_type max \
        -max_paths 20 \
        -path full
}


# =====================================================================
# 17. HOLD / MIN TIMING
# =====================================================================

redirect -file $REPORT_DIR/timing/hold_timing.rpt {
    report_timing \
        -delay_type min \
        -max_paths 20 \
        -path full
}


# =====================================================================
# 18. CONSTRAINT REPORT
# =====================================================================

redirect -file $REPORT_DIR/timing/constraints.rpt {
    report_constraint -all_violators
}


# =====================================================================
# 19. AREA
# =====================================================================

redirect -file $REPORT_DIR/area/area.rpt {
    report_area -hierarchy
}


# =====================================================================
# 20. POWER
#
# This is synthesis-level/vectorless power unless switching activity
# is explicitly annotated later.
# =====================================================================

redirect -file $REPORT_DIR/power/power.rpt {
    report_power
}


# =====================================================================
# 21. QoR
# =====================================================================

redirect -file $REPORT_DIR/synthesis/qor.rpt {
    report_qor
}


# =====================================================================
# 22. CELL REFERENCES
# =====================================================================

redirect -file $REPORT_DIR/synthesis/references.rpt {
    report_reference
}


# =====================================================================
# 23. RESOURCES
# =====================================================================

redirect -file $REPORT_DIR/synthesis/resources.rpt {
    report_resources
}


# =====================================================================
# 24. PORTS
# =====================================================================

redirect -file $REPORT_DIR/synthesis/ports.rpt {
    report_port
}


# =====================================================================
# 25. FINAL CLOCK REPORT
# =====================================================================

redirect -file $REPORT_DIR/timing/clocks_final.rpt {
    report_clocks
}


# =====================================================================
# 26. CLEAN NAMES
# =====================================================================

change_names -rules verilog -hierarchy


# =====================================================================
# 27. STAGE 04 DELIVERABLE - OPTIMIZED GATE-LEVEL NETLIST
# =====================================================================

write \
    -format verilog \
    -hierarchy \
    -output $NETLIST_DIR/tool_life_monitor_ppa_opt.v


# =====================================================================
# 28. DDC
# =====================================================================

write_file \
    -format ddc \
    -hierarchy \
    -output $NETLIST_DIR/tool_life_monitor_ppa_opt.ddc


# =====================================================================
# 29. FINAL SDC
# =====================================================================

write_sdc \
    $NETLIST_DIR/tool_life_monitor_ppa_opt.sdc


# =====================================================================
# 30. COMPLETION
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE_04 // PPA OPTIMIZATION V2 COMPLETED"
puts "================================================================="
puts " Technology       : SAED 32nm"
puts " Cell Family      : RVT"
puts " Setup Corner     : SS 0.95V 125C"
puts " Min/Hold Corner  : FF 1.16V -40C"
puts " Clock            : 10 ns / 100 MHz"
puts ""
puts " Gate-Level Netlist:"
puts " $NETLIST_DIR/tool_life_monitor_ppa_opt.v"
puts ""
puts " Reports:"
puts " $REPORT_DIR/synthesis/qor.rpt"
puts " $REPORT_DIR/area/area.rpt"
puts " $REPORT_DIR/power/power.rpt"
puts " $REPORT_DIR/timing/setup_timing.rpt"
puts " $REPORT_DIR/timing/hold_timing.rpt"
puts "================================================================="
puts ""

exit
