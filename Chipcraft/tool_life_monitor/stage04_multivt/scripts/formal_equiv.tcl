# =====================================================================
# STAGE 04 MULTI-VT / HVT - FORMAL EQUIVALENCE
#
# Reference      : Accepted golden Stage-04 DDC
# Implementation : HVT-optimized candidate DDC
#
# Goal:
# Prove that Vt remapping / leakage optimization did not change function.
# =====================================================================

set TOP "tool_life_monitor_top"

set REF_DDC \
"./stage04_final/netlist/tool_life_monitor_ppa_opt.ddc"

set IMP_DDC \
"./stage04_multivt/netlist/tool_life_monitor_multivt.ddc"

set RVT_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32rvt_ss0p95v125c.db"

set HVT_LIB \
"/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs/saed32hvt_ss0p95v125c.db"


# =====================================================================
# 1. FILE CHECKS
# =====================================================================

foreach f [list $REF_DDC $IMP_DDC $RVT_LIB $HVT_LIB] {
    if {![file exists $f]} {
        puts "ERROR: Required file not found:"
        puts $f
        exit 1
    }
}


# =====================================================================
# 2. LOAD BOTH TECHNOLOGY LIBRARIES
# =====================================================================

puts ""
puts "================================================================="
puts " LOADING RVT + HVT TECHNOLOGY LIBRARIES"
puts "================================================================="
puts ""

read_db -technology_library $RVT_LIB
read_db -technology_library $HVT_LIB


# =====================================================================
# 3. REFERENCE = ACCEPTED GOLDEN STAGE-04
# =====================================================================

puts ""
puts "================================================================="
puts " REFERENCE : GOLDEN STAGE-04"
puts "================================================================="
puts ""

read_ddc -r $REF_DDC
set_top -auto


# =====================================================================
# 4. IMPLEMENTATION = HVT CANDIDATE
# =====================================================================

puts ""
puts "================================================================="
puts " IMPLEMENTATION : STAGE-04 HVT CANDIDATE"
puts "================================================================="
puts ""

read_ddc -i $IMP_DDC
set_top -auto


# =====================================================================
# 5. MATCH
# =====================================================================

puts ""
puts "================================================================="
puts " MATCHING COMPARE POINTS"
puts "================================================================="
puts ""

match


# =====================================================================
# 6. VERIFY
# =====================================================================

puts ""
puts "================================================================="
puts " FORMAL VERIFICATION"
puts "================================================================="
puts ""

verify


# =====================================================================
# 7. DIAGNOSTICS
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
puts " MULTI-VT FORMAL EQUIVALENCE CHECK FINISHED"
puts "================================================================="
puts ""

exit
