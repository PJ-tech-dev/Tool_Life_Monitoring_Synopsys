
set TOP "tool_life_monitor_top"
set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

puts "============================================================"
puts " POST-PLACEMENT PG REPAIR: M1 RAIL -> M8 MESH"
puts "============================================================"

open_lib $DESIGN_LIB
open_block ${TOP}/placed

# ------------------------------------------------------------
# PVT
# ------------------------------------------------------------

set_process_label  -corners [get_corners default] slow
set_process_number -corners [get_corners default] 0.99
set_voltage        -corners [get_corners default] 0.95
set_temperature    -corners [get_corners default] 125

# ------------------------------------------------------------
# LOGICAL PG CONNECTION
# ------------------------------------------------------------

connect_pg_net -net VDD [get_pins -physical_context */VDD]
connect_pg_net -net VSS [get_pins -physical_context */VSS]

puts "VDD PG pins = [sizeof_collection [get_pins -physical_context */VDD]]"
puts "VSS PG pins = [sizeof_collection [get_pins -physical_context */VSS]]"

# ------------------------------------------------------------
# CRITICAL FIX
#
# Standard-cell rails : M1 horizontal
# Mesh vertical layer : M8 vertical
#
# Therefore connect existing std_conn on M1 to
# core_mesh_strategy on M8.
# ------------------------------------------------------------

set_pg_strategy_via_rule stdcell_to_m8_via_rule \
    -via_rule { \
        {{{strategies: core_mesh_strategy} {layers: M8}} \
         {{existing: std_conn} {layers: M1}} \
         {via_master: default}} \
        {{intersection: undefined} \
         {via_master: NIL}} \
    }

puts "============================================================"
puts " COMPILING M1-TO-M8 PG VIAS"
puts "============================================================"

compile_pg \
    -strategies {core_mesh_strategy} \
    -via_rule stdcell_to_m8_via_rule

# ------------------------------------------------------------
# REASSERT LOGICAL CONNECTION
# ------------------------------------------------------------

connect_pg_net -net VDD [get_pins -physical_context */VDD]
connect_pg_net -net VSS [get_pins -physical_context */VSS]

# ------------------------------------------------------------
# CHECKS
# ------------------------------------------------------------

redirect -file ./stage05/reports/pg_connectivity_m8_repair.rpt {
    check_pg_connectivity \
        -nets {VDD VSS} \
        -check_std_cell_pins all
}

redirect -file ./stage05/reports/pg_drc_m8_repair.rpt {
    check_pg_drc -nets {VDD VSS}
}

save_block -as ${TOP}/placed_pg_connected
save_lib

puts ""
puts "============================================================"
puts " M1-TO-M8 PG REPAIR COMPLETE"
puts "============================================================"
puts ""

exit

