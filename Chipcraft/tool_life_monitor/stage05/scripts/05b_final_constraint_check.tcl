
open_lib ./stage05/work/tool_life_monitor.nlib
open_block tool_life_monitor_top/routed_final_clean

set_process_label  -corners [get_corners default] slow
set_process_number -corners [get_corners default] 0.99
set_voltage        -corners [get_corners default] 0.95
set_temperature    -corners [get_corners default] 125

redirect -file ./stage05/reports/maxcap_final_clean.rpt {
    report_constraints \
        -max_capacitance \
        -all_violators \
        -verbose
}

redirect -file ./stage05/reports/qor_final_clean.rpt {
    report_qor
}

puts "FINAL CONSTRAINT CHECK COMPLETE"
exit
