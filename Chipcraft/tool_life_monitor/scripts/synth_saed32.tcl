# =====================================================================
# TOOL LIFE MONITOR
# SAED 32nm RVT SYNTHESIS FLOW
#
# Technology      : SAED 32nm
# Cell Family     : RVT
# Setup / Max     : SS 0.95V 125C
# Hold  / Min     : FF 1.16V -40C
# Clock           : 10 ns = 100 MHz
#
# Tool            : Synopsys Design Compiler
# =====================================================================


# =====================================================================
# 1. PROJECT SETTINGS
# =====================================================================

set TOP            "tool_life_monitor_top"

set RTL_DIR        "./rtl"
set CONSTRAINT_DIR "./constraints"

set NETLIST_DIR    "./netlist/saed32"
set REPORT_DIR     "./reports/saed32"


# =====================================================================
# 2. CREATE OUTPUT DIRECTORIES
# =====================================================================

file mkdir $NETLIST_DIR

file mkdir $REPORT_DIR
file mkdir $REPORT_DIR/timing
file mkdir $REPORT_DIR/area
file mkdir $REPORT_DIR/power
file mkdir $REPORT_DIR/synthesis


# =====================================================================
# 3. SAED 32nm LIBRARY PATHS
# =====================================================================

# Slow corner:
# RVT / Slow-Slow / 0.95 V / 125 C
# Used for setup (maximum delay) analysis.

set MAX_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ss0p95v125c.db"


# Fast corner:
# RVT / Fast-Fast / 1.16 V / -40 C
# Used for hold (minimum delay) analysis.

set MIN_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ff1p16vn40c.db"


# =====================================================================
# 4. VERIFY LIBRARY FILES EXIST
# =====================================================================

if {![file exists $MAX_LIB]} {
    puts "ERROR: Maximum-delay library does not exist:"
    puts "$MAX_LIB"
    exit 1
}

if {![file exists $MIN_LIB]} {
    puts "ERROR: Minimum-delay library does not exist:"
    puts "$MIN_LIB"
    exit 1
}

puts ""
puts "SAED32 library files found successfully."
puts "MAX LIB = $MAX_LIB"
puts "MIN LIB = $MIN_LIB"
puts ""


# =====================================================================
# 5. DESIGN COMPILER LIBRARY SETUP
# =====================================================================

set_app_var search_path [list . $RTL_DIR]

set_app_var target_library [list $MAX_LIB]

set_app_var link_library "* $MAX_LIB $MIN_LIB"


# Associate the slow setup library with the fast hold library.
#
# IMPORTANT:
# Use the actual .db file paths here. Do NOT use only the internal
# library names, because that caused TIM-120 in the previous run.

set_min_library $MAX_LIB \
    -min_version $MIN_LIB


# =====================================================================
# 6. READ / ANALYZE RTL
# =====================================================================

puts ""
puts "============================================================"
puts " ANALYZING RTL"
puts "============================================================"
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
# 7. ELABORATE TOP DESIGN
# =====================================================================

puts ""
puts "============================================================"
puts " ELABORATING DESIGN"
puts "============================================================"
puts ""

elaborate $TOP

current_design $TOP


# =====================================================================
# 8. LINK AGAINST SAED32
# =====================================================================

puts ""
puts "============================================================"
puts " LINKING DESIGN WITH SAED32"
puts "============================================================"
puts ""

link


# =====================================================================
# 9. PRE-SYNTHESIS DESIGN CHECK
# =====================================================================

redirect -file $REPORT_DIR/synthesis/check_design_pre.rpt {
    check_design
}


# =====================================================================
# 10. APPLY SDC CONSTRAINTS
# =====================================================================

puts ""
puts "============================================================"
puts " APPLYING TIMING CONSTRAINTS"
puts "============================================================"
puts ""

source $CONSTRAINT_DIR/tool_life_monitor.sdc


# =====================================================================
# 11. PRE-SYNTHESIS TIMING CHECKS
# =====================================================================

redirect -file $REPORT_DIR/timing/check_timing_pre.rpt {
    check_timing
}

redirect -file $REPORT_DIR/timing/clocks.rpt {
    report_clocks
}

redirect -file $REPORT_DIR/synthesis/ports.rpt {
    report_port
}


# =====================================================================
# 12. SYNTHESIS / OPTIMIZATION
# =====================================================================

puts ""
puts "============================================================"
puts " RUNNING COMPILE_ULTRA"
puts "============================================================"
puts ""

compile_ultra


# =====================================================================
# 13. POST-SYNTHESIS DESIGN CHECK
# =====================================================================

redirect -file $REPORT_DIR/synthesis/check_design_post.rpt {
    check_design
}


# =====================================================================
# 14. POST-SYNTHESIS TIMING CHECK
# =====================================================================

redirect -file $REPORT_DIR/timing/check_timing_post.rpt {
    check_timing
}


# =====================================================================
# 15. SETUP / MAX-DELAY TIMING REPORT
# =====================================================================

redirect -file $REPORT_DIR/timing/setup_timing.rpt {
    report_timing \
        -delay_type max \
        -max_paths 10 \
        -path full
}


# =====================================================================
# 16. HOLD / MIN-DELAY TIMING REPORT
# =====================================================================

redirect -file $REPORT_DIR/timing/hold_timing.rpt {
    report_timing \
        -delay_type min \
        -max_paths 10 \
        -path full
}


# =====================================================================
# 17. TIMING CONSTRAINT VIOLATIONS
# =====================================================================

redirect -file $REPORT_DIR/timing/constraints.rpt {
    report_constraint -all_violators
}


# =====================================================================
# 18. AREA REPORT
# =====================================================================

redirect -file $REPORT_DIR/area/area.rpt {
    report_area -hierarchy
}


# =====================================================================
# 19. POWER REPORT
# =====================================================================

redirect -file $REPORT_DIR/power/power.rpt {
    report_power
}


# =====================================================================
# 20. QUALITY OF RESULTS REPORT
# =====================================================================

redirect -file $REPORT_DIR/synthesis/qor.rpt {
    report_qor
}


# =====================================================================
# 21. RESOURCE INFERENCE REPORT
# =====================================================================

redirect -file $REPORT_DIR/synthesis/resources.rpt {
    report_resources
}


# =====================================================================
# 22. STANDARD-CELL USAGE REPORT
# =====================================================================

redirect -file $REPORT_DIR/synthesis/references.rpt {
    report_reference
}


# =====================================================================
# 23. CLEAN NAMES FOR VERILOG / PHYSICAL DESIGN
# =====================================================================

change_names -rules verilog -hierarchy


# =====================================================================
# 24. WRITE SAED32 GATE-LEVEL NETLIST
# =====================================================================

write \
    -format verilog \
    -hierarchy \
    -output $NETLIST_DIR/tool_life_monitor_saed32_syn.v


# =====================================================================
# 25. WRITE DESIGN COMPILER DATABASE
# =====================================================================

write_file \
    -format ddc \
    -hierarchy \
    -output $NETLIST_DIR/tool_life_monitor_saed32.ddc


# =====================================================================
# 26. WRITE SYNTHESIZED SDC
# =====================================================================

write_sdc \
    $NETLIST_DIR/tool_life_monitor_saed32.sdc


# =====================================================================
# 27. FINAL SUMMARY
# =====================================================================

puts ""
puts "================================================================="
puts " TOOL LIFE MONITOR - SAED 32nm SYNTHESIS COMPLETED"
puts "================================================================="
puts " Technology       : SAED 32nm"
puts " Standard cells   : RVT"
puts " Setup corner     : SS 0.95V 125C"
puts " Hold corner      : FF 1.16V -40C"
puts " Clock target     : 10 ns / 100 MHz"
puts ""
puts " Reports:"
puts " $REPORT_DIR/timing/setup_timing.rpt"
puts " $REPORT_DIR/timing/hold_timing.rpt"
puts " $REPORT_DIR/timing/constraints.rpt"
puts " $REPORT_DIR/area/area.rpt"
puts " $REPORT_DIR/power/power.rpt"
puts " $REPORT_DIR/synthesis/qor.rpt"
puts " $REPORT_DIR/synthesis/resources.rpt"
puts " $REPORT_DIR/synthesis/references.rpt"
puts ""
puts " Netlist:"
puts " $NETLIST_DIR/tool_life_monitor_saed32_syn.v"
puts ""
puts " DDC:"
puts " $NETLIST_DIR/tool_life_monitor_saed32.ddc"
puts "================================================================="
puts ""

exit
