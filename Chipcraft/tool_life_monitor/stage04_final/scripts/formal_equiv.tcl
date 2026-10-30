# =====================================================================
# STAGE 04 - FORMAL EQUIVALENCE VERIFICATION
#
# Reference      : Frozen Stage-03 synthesized DDC
# Implementation : Stage-04 PPA optimized DDC
#
# Goal:
# Prove that post-synthesis PPA optimization did not change functionality.
# =====================================================================

set TOP "tool_life_monitor_top"

set REF_DDC \
"./netlist/saed32/tool_life_monitor_saed32_baseline.ddc"

set IMP_DDC \
"./stage04_final/netlist/tool_life_monitor_ppa_opt.ddc"

set TECH_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ss0p95v125c.db"


# =====================================================================
# 1. CHECK FILES
# =====================================================================

if {![file exists $REF_DDC]} {
    puts "ERROR: Reference DDC not found:"
    puts "$REF_DDC"
    exit 1
}

if {![file exists $IMP_DDC]} {
    puts "ERROR: Implementation DDC not found:"
    puts "$IMP_DDC"
    exit 1
}

if {![file exists $TECH_LIB]} {
    puts "ERROR: Technology library not found:"
    puts "$TECH_LIB"
    exit 1
}


# =====================================================================
# 2. LOAD SHARED SAED32 TECHNOLOGY LIBRARY
# =====================================================================

puts ""
puts "================================================================="
puts " LOADING SAED32 TECHNOLOGY LIBRARY"
puts "================================================================="
puts ""

read_db -technology_library $TECH_LIB


# =====================================================================
# 3. READ REFERENCE DESIGN
# =====================================================================

puts ""
puts "================================================================="
puts " REFERENCE : STAGE-03 BASELINE"
puts "================================================================="
puts ""

read_ddc -r $REF_DDC

set_top -auto


# =====================================================================
# 4. READ IMPLEMENTATION DESIGN
# =====================================================================

puts ""
puts "================================================================="
puts " IMPLEMENTATION : STAGE-04 PPA OPTIMIZED"
puts "================================================================="
puts ""

read_ddc -i $IMP_DDC

set_top -auto


# =====================================================================
# 5. MATCH COMPARE POINTS
# =====================================================================

puts ""
puts "================================================================="
puts " MATCHING REFERENCE AND IMPLEMENTATION"
puts "================================================================="
puts ""

match


# =====================================================================
# 6. FORMAL VERIFICATION
# =====================================================================

puts ""
puts "================================================================="
puts " RUNNING FORMAL EQUIVALENCE VERIFICATION"
puts "================================================================="
puts ""

verify


# =====================================================================
# 7. DIAGNOSTIC REPORTS
# =====================================================================

puts ""
puts "================================================================="
puts " UNMATCHED POINTS"
puts "================================================================="
puts ""

report_unmatched_points

puts ""
puts "================================================================="
puts " FAILING POINTS"
puts "================================================================="
puts ""

report_failing_points

puts ""
puts "================================================================="
puts " STAGE-04 FORMAL EQUIVALENCE CHECK FINISHED"
puts "================================================================="
puts ""

exit
