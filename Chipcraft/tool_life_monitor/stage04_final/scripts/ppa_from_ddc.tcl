# =====================================================================
# STAGE_04 // PPA OPTIMIZATION
# Start from frozen Stage-03 synthesized DDC
# No RTL analyze / elaborate / compile_ultra
# =====================================================================

set TOP "tool_life_monitor_top"

set BASE_DDC "./netlist/saed32/tool_life_monitor_saed32_baseline.ddc"

set OUT_DIR    "./stage04_final"
set REPORT_DIR "$OUT_DIR/reports"
set NETLIST_DIR "$OUT_DIR/netlist"

# ---------------------------------------------------------------------
# SAED32 libraries
# ---------------------------------------------------------------------

set MAX_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ss0p95v125c.db"

set MIN_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ff1p16vn40c.db"


# =====================================================================
# 1. FILE CHECKS
# =====================================================================

if {![file exists $BASE_DDC]} {
    puts "ERROR: Baseline DDC not found:"
    puts "$BASE_DDC"
    exit 1
}

if {![file exists $MAX_LIB]} {
    puts "ERROR: MAX library not found:"
    puts "$MAX_LIB"
    exit 1
}

if {![file exists $MIN_LIB]} {
    puts "ERROR: MIN library not found:"
    puts "$MIN_LIB"
    exit 1
}


# =====================================================================
# 2. LIBRARY ENVIRONMENT
# =====================================================================

set_app_var target_library [list $MAX_LIB]
set_app_var link_library "* $MAX_LIB $MIN_LIB"

set_min_library $MAX_LIB -min_version $MIN_LIB


# =====================================================================
# 3. READ FROZEN STAGE-03 SYNTHESIZED DESIGN
# =====================================================================

puts ""
puts "================================================================="
puts " READING FROZEN STAGE-03 DDC"
puts "================================================================="
puts ""

read_ddc $BASE_DDC

current_design $TOP


# Re-assert library environment after DDC load
set_app_var target_library [list $MAX_LIB]
set_app_var link_library "* $MAX_LIB $MIN_LIB"

set_min_library $MAX_LIB -min_version $MIN_LIB

link


# =====================================================================
# 4. STAGE-04 PRE-CTS CONSTRAINT METHODOLOGY
#
# No official PPA/timing margins were supplied.
#
# Existing Stage-03 clock / I/O delays remain in the DDC.
#
# Setup uncertainty = 0.20 ns engineering margin.
# Hold uncertainty  = 0.00 ns pre-CTS assumption.
#
# Physical hold will be re-evaluated after CTS in ICC2.
# =====================================================================

set_clock_uncertainty -setup 0.20 [get_clocks CLK]
set_clock_uncertainty -hold  0.00 [get_clocks CLK]


# =====================================================================
# 5. VERIFY DESIGN BEFORE OPTIMIZATION
# =====================================================================

redirect -file $REPORT_DIR/baseline/check_design.rpt {
    check_design
}

redirect -file $REPORT_DIR/baseline/check_timing.rpt {
    check_timing
}


# =====================================================================
# 6. BASELINE REPORTS
# =====================================================================

redirect -file $REPORT_DIR/baseline/qor.rpt {
    report_qor
}

redirect -file $REPORT_DIR/baseline/area.rpt {
    report_area -hierarchy
}

redirect -file $REPORT_DIR/baseline/power.rpt {
    report_power
}

redirect -file $REPORT_DIR/baseline/setup_timing.rpt {
    report_timing \
        -delay_type max \
        -max_paths 20 \
        -path full
}

redirect -file $REPORT_DIR/baseline/hold_timing.rpt {
    report_timing \
        -delay_type min \
        -max_paths 20 \
        -path full
}

redirect -file $REPORT_DIR/baseline/constraints.rpt {
    report_constraint -all_violators
}


# =====================================================================
# 7. ACTUAL STAGE-04 POST-SYNTHESIS PPA OPTIMIZATION
#
# IMPORTANT:
# - No analyze
# - No elaborate
# - No compile_ultra
#
# optimize_netlist -area is the supported command recommended by
# this installed DC version.
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE 04 : POST-SYNTHESIS AREA / PPA OPTIMIZATION"
puts "================================================================="
puts ""

optimize_netlist -area


# =====================================================================
# 8. FINAL VALIDATION
# =====================================================================

redirect -file $REPORT_DIR/final/check_design.rpt {
    check_design
}

redirect -file $REPORT_DIR/final/check_timing.rpt {
    check_timing
}


# =====================================================================
# 9. FINAL QoR
# =====================================================================

redirect -file $REPORT_DIR/final/qor.rpt {
    report_qor
}


# =====================================================================
# 10. FINAL AREA
# =====================================================================

redirect -file $REPORT_DIR/final/area.rpt {
    report_area -hierarchy
}


# =====================================================================
# 11. FINAL POWER
# =====================================================================

redirect -file $REPORT_DIR/final/power.rpt {
    report_power
}


# =====================================================================
# 12. FINAL SETUP TIMING
# =====================================================================

redirect -file $REPORT_DIR/final/setup_timing.rpt {
    report_timing \
        -delay_type max \
        -max_paths 20 \
        -path full
}


# =====================================================================
# 13. FINAL HOLD TIMING
# =====================================================================

redirect -file $REPORT_DIR/final/hold_timing.rpt {
    report_timing \
        -delay_type min \
        -max_paths 20 \
        -path full
}


# =====================================================================
# 14. FINAL CONSTRAINT REPORT
# =====================================================================

redirect -file $REPORT_DIR/final/constraints.rpt {
    report_constraint -all_violators
}


# =====================================================================
# 15. CELL / REFERENCE REPORT
# =====================================================================

redirect -file $REPORT_DIR/final/references.rpt {
    report_reference
}


# =====================================================================
# 16. WRITE FINAL OPTIMIZED DESIGN
# =====================================================================

change_names -rules verilog -hierarchy

write \
    -format verilog \
    -hierarchy \
    -output $NETLIST_DIR/tool_life_monitor_ppa_opt.v

write_file \
    -format ddc \
    -hierarchy \
    -output $NETLIST_DIR/tool_life_monitor_ppa_opt.ddc

write_sdc \
    $NETLIST_DIR/tool_life_monitor_ppa_opt.sdc


# =====================================================================
# 17. COMPLETION
# =====================================================================

puts ""
puts "================================================================="
puts " STAGE_04 // PPA OPTIMIZATION COMPLETE"
puts "================================================================="
puts "Input  : $BASE_DDC"
puts "Output : $NETLIST_DIR/tool_life_monitor_ppa_opt.v"
puts ""
puts "IMPORTANT:"
puts "This run started from the frozen Stage-03 synthesized DDC."
puts "No RTL resynthesis was performed."
puts "================================================================="
puts ""

exit
