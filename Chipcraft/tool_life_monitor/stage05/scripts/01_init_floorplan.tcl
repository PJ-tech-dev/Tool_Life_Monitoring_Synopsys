
set TOP "tool_life_monitor_top"

set NETLIST "./final_netlist/tool_life_monitor_hvt_final.v"
set SDC     "./final_netlist/tool_life_monitor_hvt_final.sdc"

set REFROOT "/home/prem5111/Downloads/pd_scripts-20250304T122158Z-001_modified/pd_scripts-20250304T122158Z-001/pd_scripts/ref"

set TECH       "$REFROOT/tech/saed32nm_1p9m.tf"
set HVT_NDM    "$REFROOT/CLIBs/saed32_hvt.ndm"

set TLU_MAX    "$REFROOT/tech/saed32nm_1p9m_Cmax.lv.tluplus"
set TLU_MIN    "$REFROOT/tech/saed32nm_1p9m_Cmin.lv.tluplus"
set TLU_MAP    "$REFROOT/tech/saed32nm_tf_itf_tluplus.map"

set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

puts "============================================================"
puts " STAGE 05 - INITIALIZATION + FLOORPLAN"
puts "============================================================"

# ------------------------------------------------------------
# CREATE DESIGN LIBRARY
# ------------------------------------------------------------

create_lib \
    -technology $TECH \
    -ref_libs [list $HVT_NDM] \
    $DESIGN_LIB

# ------------------------------------------------------------
# READ FINAL HVT NETLIST
# ------------------------------------------------------------

read_verilog $NETLIST

current_block $TOP
link_block

puts "Current block:"
puts [get_object_name [current_block]]

puts "Instance count:"
puts [sizeof_collection [get_cells -hierarchical *]]

# ------------------------------------------------------------
# READ CONSTRAINTS
# ------------------------------------------------------------

read_sdc $SDC

# ------------------------------------------------------------
# PARASITIC TECHNOLOGY
# ------------------------------------------------------------

read_parasitic_tech \
    -tlup $TLU_MAX \
    -layermap $TLU_MAP \
    -name maxTLU

read_parasitic_tech \
    -tlup $TLU_MIN \
    -layermap $TLU_MAP \
    -name minTLU

set_parasitic_parameters \
    -late_spec maxTLU \
    -early_spec minTLU

# ------------------------------------------------------------
# PRE-FLOORPLAN CHECK
# ------------------------------------------------------------

puts "============================================================"
puts " PRE-FLOORPLAN DESIGN CHECK"
puts "============================================================"

check_design \
    -checks {dp_pre_floorplan} \
    -log_file ./stage05/reports/check_design_pre_floorplan.rpt

# ------------------------------------------------------------
# CLOCK REPORT
# ------------------------------------------------------------

redirect -file ./stage05/reports/clocks_pre_floorplan.rpt {
    report_clocks
}

# ------------------------------------------------------------
# INITIAL FLOORPLAN
# ------------------------------------------------------------

puts "============================================================"
puts " CREATING FLOORPLAN"
puts "============================================================"

initialize_floorplan \
    -shape R \
    -core_utilization 0.60 \
    -side_ratio {1 1} \
    -core_offset {5 5}

# ------------------------------------------------------------
# POST-FLOORPLAN CHECK
# ------------------------------------------------------------

check_design \
    -checks {dp_floorplan_rules} \
    -log_file ./stage05/reports/check_design_post_floorplan.rpt

# ------------------------------------------------------------
# REPORT FLOORPLAN
# ------------------------------------------------------------

redirect -file ./stage05/reports/floorplan_utilization.rpt {
    report_utilization
}

# ------------------------------------------------------------
# SAVE BLOCK
# ------------------------------------------------------------

save_block -as ${TOP}/floorplan_initial

puts ""
puts "============================================================"
puts " INITIAL FLOORPLAN COMPLETE"
puts "============================================================"
puts ""

exit

