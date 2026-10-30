
set TOP "tool_life_monitor_top"
set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

puts "============================================================"
puts " POST-PLACEMENT PG CONNECTIVITY REPAIR"
puts "============================================================"

open_lib $DESIGN_LIB
open_block ${TOP}/placed

# ------------------------------------------------------------
# KEEP PVT CONSISTENT WITH HVT IMPLEMENTATION
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

puts "VDD physical pins:"
puts [sizeof_collection [get_pins -physical_context */VDD]]

puts "VSS physical pins:"
puts [sizeof_collection [get_pins -physical_context */VSS]]

# ------------------------------------------------------------
# CONNECT M1 STANDARD-CELL RAILS TO M7 POWER MESH
#
# std_conn = standard-cell PG rails generated on M1
# core_mesh_strategy/M7 = existing horizontal mesh
# ------------------------------------------------------------

set_pg_strategy_via_rule rail_to_mesh_via_rule \
    -via_rule { \
        {{{existing: std_conn}} \
         {{strategies: core_mesh_strategy} {layers: M7}} \
         {via_master: default}} \
        {{intersection: undefined} \
         {via_master: nil}} \
    }

puts "============================================================"
puts " CONNECTING STANDARD-CELL RAILS TO MESH"
puts "============================================================"

compile_pg \
    -strategies core_mesh_strategy \
    -via_rule rail_to_mesh_via_rule

# Reassert logical PG connection after physical PG generation.
connect_pg_net -net VDD [get_pins -physical_context */VDD]
connect_pg_net -net VSS [get_pins -physical_context */VSS]

# ------------------------------------------------------------
# CHECK PG CONNECTIVITY
# ------------------------------------------------------------

redirect -file ./stage05/reports/pg_connectivity_repaired.rpt {
    check_pg_connectivity \
        -nets {VDD VSS} \
        -check_std_cell_pins all
}

redirect -file ./stage05/reports/pg_drc_repaired.rpt {
    check_pg_drc -nets {VDD VSS}
}

# ------------------------------------------------------------
# SAVE
# ------------------------------------------------------------

save_block -as ${TOP}/placed_pg
save_lib

puts ""
puts "============================================================"
puts " PG REPAIR COMPLETE"
puts "============================================================"
puts ""

exit

