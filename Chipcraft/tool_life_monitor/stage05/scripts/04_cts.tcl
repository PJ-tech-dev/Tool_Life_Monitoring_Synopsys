
set TOP "tool_life_monitor_top"
set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

puts "============================================================"
puts " STAGE 05 - CLOCK TREE SYNTHESIS"
puts "============================================================"

# ------------------------------------------------------------
# OPEN CLEAN POST-PLACEMENT + PG CHECKPOINT
# ------------------------------------------------------------

open_lib $DESIGN_LIB
open_block ${TOP}/placed_pg_reference

puts "Current block:"
puts [get_object_name [current_block]]

# ------------------------------------------------------------
# PVT
# Match the HVT synthesis / physical implementation corner
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
# CLOCK CHECK
# ------------------------------------------------------------

puts "============================================================"
puts " CLOCK CHECK"
puts "============================================================"

report_clocks

# ------------------------------------------------------------
# CTS REFERENCE CELLS
#
# Use only ordinary HVT buffers/inverters.
# Avoid input buffers, tri-state buffers and very large X32
# drivers for this small 128-register clock tree.
# ------------------------------------------------------------

set CTS_CELLS [get_lib_cells {
    */NBUFFX2_HVT
    */NBUFFX4_HVT
    */NBUFFX8_HVT
    */NBUFFX16_HVT
    */INVX1_HVT
    */INVX2_HVT
    */INVX4_HVT
    */INVX8_HVT
    */INVX16_HVT
}]

puts "CTS reference-cell count:"
puts [sizeof_collection $CTS_CELLS]

# Restrict CTS to the selected HVT references.
set_lib_cell_purpose -exclude cts [get_lib_cells]
set_lib_cell_purpose -include cts $CTS_CELLS

# ------------------------------------------------------------
# PRE-CTS SANITY CHECK
# ------------------------------------------------------------

puts "============================================================"
puts " PRE-CTS CHECK"
puts "============================================================"

check_design \
    -checks {pre_clock_tree_stage} \
    -log_file ./stage05/reports/check_design_pre_cts.rpt

redirect -file ./stage05/reports/setup_pre_cts.rpt {
    report_timing -delay_type max -max_paths 20
}

redirect -file ./stage05/reports/hold_pre_cts.rpt {
    report_timing -delay_type min -max_paths 20
}

# ------------------------------------------------------------
# CLOCK TREE SYNTHESIS + CLOCK DETAIL ROUTING
#
# build_clock:
#   creates/balances physical clock tree
#
# route_clock:
#   detail-routes clock nets
#
# Do not run final_opto yet. We inspect CTS first.
# ------------------------------------------------------------

puts "============================================================"
puts " RUNNING CLOCK_OPT THROUGH ROUTE_CLOCK"
puts "============================================================"

clock_opt -to route_clock

# ------------------------------------------------------------
# POST-CTS PG CONNECTION
#
# clock_opt can insert new HVT clock buffers/inverters.
# Reassert their logical VDD/VSS connectivity.
# Existing M1 rails provide the physical row supply.
# ------------------------------------------------------------

connect_pg_net -automatic

# ------------------------------------------------------------
# POST-CTS REPORTS
# ------------------------------------------------------------

puts "============================================================"
puts " POST-CTS REPORTING"
puts "============================================================"

redirect -file ./stage05/reports/clocks_after_cts.rpt {
    report_clocks
}

redirect -file ./stage05/reports/clock_qor_after_cts.rpt {
    report_clock_qor
}

redirect -file ./stage05/reports/setup_after_cts.rpt {
    report_timing -delay_type max -max_paths 20
}

redirect -file ./stage05/reports/hold_after_cts.rpt {
    report_timing -delay_type min -max_paths 20
}

redirect -file ./stage05/reports/qor_after_cts.rpt {
    report_qor
}

redirect -file ./stage05/reports/utilization_after_cts.rpt {
    report_utilization
}

# ------------------------------------------------------------
# CHECK PG AGAIN AFTER CTS CELL INSERTION
# ------------------------------------------------------------

redirect -file ./stage05/reports/pg_connectivity_after_cts.rpt {
    check_pg_connectivity \
        -nets {VDD VSS} \
        -check_std_cell_pins all
}

redirect -file ./stage05/reports/pg_drc_after_cts.rpt {
    check_pg_drc -nets {VDD VSS}
}

# ------------------------------------------------------------
# SAVE CTS CHECKPOINT
# ------------------------------------------------------------

save_block -as ${TOP}/cts
save_lib

puts ""
puts "============================================================"
puts " CTS COMPLETE"
puts "============================================================"
puts ""

exit

