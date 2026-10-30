
set TOP "tool_life_monitor_top"
set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

puts "============================================================"
puts " STAGE 05 - POST CTS FINAL OPTIMIZATION"
puts "============================================================"

# ------------------------------------------------------------
# OPEN CLEAN CTS CHECKPOINT
# ------------------------------------------------------------

open_lib $DESIGN_LIB
open_block ${TOP}/cts

puts "Current block:"
puts [get_object_name [current_block]]

# ------------------------------------------------------------
# PVT
# ------------------------------------------------------------

set_process_label  -corners [get_corners default] slow
set_process_number -corners [get_corners default] 0.99
set_voltage        -corners [get_corners default] 0.95
set_temperature    -corners [get_corners default] 125

puts "============================================================"
puts " PVT CHECK"
puts "============================================================"

report_pvt -significant_digits 3

# ------------------------------------------------------------
# BEFORE FINAL_OPTO REPORTS
# ------------------------------------------------------------

redirect -file ./stage05/reports/setup_before_final_opto.rpt {
    report_timing -delay_type max -max_paths 20
}

redirect -file ./stage05/reports/hold_before_final_opto.rpt {
    report_timing -delay_type min -max_paths 20
}

# ------------------------------------------------------------
# FINAL CTS / PREROUTE OPTIMIZATION
#
# This is the third clock_opt stage.
# It also performs signal global routing.
# ------------------------------------------------------------

puts "============================================================"
puts " RUNNING CLOCK_OPT FINAL_OPTO"
puts "============================================================"

clock_opt -from final_opto -to final_opto

# ------------------------------------------------------------
# PG CONNECTION
# Reassert in case optimization inserted/replaced cells.
# ------------------------------------------------------------

connect_pg_net -automatic

# ------------------------------------------------------------
# POST FINAL_OPTO REPORTS
# ------------------------------------------------------------

redirect -file ./stage05/reports/setup_after_final_opto.rpt {
    report_timing -delay_type max -max_paths 20
}

redirect -file ./stage05/reports/hold_after_final_opto.rpt {
    report_timing -delay_type min -max_paths 20
}

redirect -file ./stage05/reports/qor_after_final_opto.rpt {
    report_qor
}

redirect -file ./stage05/reports/clock_qor_after_final_opto.rpt {
    report_clock_qor
}

redirect -file ./stage05/reports/utilization_after_final_opto.rpt {
    report_utilization
}

# ------------------------------------------------------------
# PG VALIDATION
# ------------------------------------------------------------

redirect -file ./stage05/reports/pg_connectivity_after_final_opto.rpt {
    check_pg_connectivity \
        -nets {VDD VSS} \
        -check_std_cell_pins all
}

redirect -file ./stage05/reports/pg_drc_after_final_opto.rpt {
    check_pg_drc -nets {VDD VSS}
}

# ------------------------------------------------------------
# SAVE
# ------------------------------------------------------------

save_block -as ${TOP}/cts_opt
save_lib

puts ""
puts "============================================================"
puts " POST CTS FINAL OPTIMIZATION COMPLETE"
puts "============================================================"
puts ""

exit

