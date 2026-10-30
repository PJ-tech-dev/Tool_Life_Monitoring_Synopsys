
set TOP "tool_life_monitor_top"
set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

puts "============================================================"
puts " FINAL ICC2 LVS CHECK"
puts "============================================================"

open_lib $DESIGN_LIB
open_block ${TOP}/routed_final_clean

puts "Current block:"
puts [get_object_name [current_block]]

# ------------------------------------------------------------
# FINAL LVS / CONNECTIVITY CHECK
# ------------------------------------------------------------

puts "============================================================"
puts " RUNNING CHECK_LVS"
puts "============================================================"

redirect -file ./stage05/reports/check_lvs_final_clean.rpt {
    check_lvs
}

puts ""
puts "============================================================"
puts " FINAL LVS CHECK COMPLETE"
puts "============================================================"

exit

