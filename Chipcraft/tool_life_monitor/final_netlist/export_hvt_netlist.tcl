
set LIBROOT "/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref/DBs"

set HVT_MAX "$LIBROOT/saed32hvt_ss0p95v125c.db"

set RVT_MAX "$LIBROOT/saed32rvt_ss0p95v125c.db"
set RVT_MIN "$LIBROOT/saed32rvt_ff1p16vn40c.db"

set_app_var target_library [list $HVT_MAX]

set_app_var link_library [list \
    "*" \
    $HVT_MAX \
    $RVT_MAX \
    $RVT_MIN \
]

# Establish the RVT max/min relationship expected by the saved DDC
set_min_library $RVT_MAX -min_version $RVT_MIN

puts "=================================================="
puts " READING FINAL HVT/MULTIVT DDC"
puts "=================================================="

read_ddc ./stage04_multivt/netlist/tool_life_monitor_multivt.ddc

current_design tool_life_monitor_top
link

puts "=================================================="
puts " CURRENT DESIGN"
puts "=================================================="
puts [get_object_name [current_design]]

puts "=================================================="
puts " DESIGN CHECK"
puts "=================================================="

check_design

file mkdir ./final_netlist
file mkdir ./final_netlist/reports

change_names -rules verilog -hierarchy

puts "=================================================="
puts " WRITING FINAL GATE-LEVEL VERILOG"
puts "=================================================="

write -format verilog -hierarchy \
    -output ./final_netlist/tool_life_monitor_hvt_final.v

puts "=================================================="
puts " WRITING FINAL DDC"
puts "=================================================="

write -format ddc -hierarchy \
    -output ./final_netlist/tool_life_monitor_hvt_final.ddc

puts "=================================================="
puts " WRITING FINAL SDC"
puts "=================================================="

write_sdc \
    ./final_netlist/tool_life_monitor_hvt_final.sdc

redirect ./final_netlist/reports/check_design.rpt {
    check_design
}

redirect ./final_netlist/reports/area.rpt {
    report_area
}

redirect ./final_netlist/reports/power.rpt {
    report_power
}

redirect ./final_netlist/reports/qor.rpt {
    report_qor
}

redirect ./final_netlist/reports/references.rpt {
    report_reference
}

redirect ./final_netlist/reports/vth.rpt {
    report_threshold_voltage_group
}

puts "=================================================="
puts " FINAL HVT NETLIST EXPORT COMPLETE"
puts "=================================================="

exit
