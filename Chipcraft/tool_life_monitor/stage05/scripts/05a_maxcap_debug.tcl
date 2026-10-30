
set TOP "tool_life_monitor_top"
set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

open_lib $DESIGN_LIB
open_block ${TOP}/routed_final

# Match implementation PVT
set_process_label  -corners [get_corners default] slow
set_process_number -corners [get_corners default] 0.99
set_voltage        -corners [get_corners default] 0.95
set_temperature    -corners [get_corners default] 125

report_pvt -significant_digits 3

redirect -file ./stage05/reports/maxcap_violator.rpt {
    report_constraints \
        -max_capacitance \
        -all_violators \
        -verbose
}

puts "MAXCAP DEBUG COMPLETE"

exit
