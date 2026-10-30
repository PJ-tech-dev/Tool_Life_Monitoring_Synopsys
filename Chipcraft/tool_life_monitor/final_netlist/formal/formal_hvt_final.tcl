
set LIBROOT "/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs"

set HVT_MAX "$LIBROOT/saed32hvt_ss0p95v125c.db"
set RVT_MAX "$LIBROOT/saed32rvt_ss0p95v125c.db"
set RVT_MIN "$LIBROOT/saed32rvt_ff1p16vn40c.db"

set REF_DDC "./netlist/saed32/tool_life_monitor_saed32_baseline.ddc"
set IMP_DDC "./final_netlist/tool_life_monitor_hvt_final.ddc"

puts "=================================================="
puts " LOADING TECHNOLOGY LIBRARIES"
puts "=================================================="

read_db -technology_library $RVT_MAX
read_db -technology_library $RVT_MIN
read_db -technology_library $HVT_MAX

puts "=================================================="
puts " READING REFERENCE DESIGN"
puts "=================================================="

read_ddc -r $REF_DDC
set_top -auto

puts "=================================================="
puts " READING FINAL HVT IMPLEMENTATION"
puts "=================================================="

read_ddc -i $IMP_DDC
set_top -auto

puts "=================================================="
puts " MATCH"
puts "=================================================="

match

puts "=================================================="
puts " VERIFY"
puts "=================================================="

verify

puts "=================================================="
puts " UNMATCHED POINTS"
puts "=================================================="

report_unmatched_points

puts "=================================================="
puts " FAILING POINTS"
puts "=================================================="

report_failing_points

puts "=================================================="
puts " FORMAL CHECK COMPLETE"
puts "=================================================="

exit
