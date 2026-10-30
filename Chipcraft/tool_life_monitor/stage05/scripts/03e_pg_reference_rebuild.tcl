
set TOP "tool_life_monitor_top"
set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

puts "============================================================"
puts " SAED32 REFERENCE PG REBUILD"
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
# REMOVE PREVIOUS EXPERIMENTAL PG
# Placement itself is retained.
# ------------------------------------------------------------

remove_pg_strategies -all
remove_pg_patterns -all
remove_pg_regions -all
remove_pg_via_master_rules -all
remove_pg_strategy_via_rules -all

remove_routes -net_types {power ground} -ring -stripe -macro_pin_connect -lib_cell_pin_connect

puts "Previous PG structures removed."

# ------------------------------------------------------------
# CREATE TOP-LEVEL PG PORTS
# SAED32 reference powerplan.tcl lines 7-9
# ------------------------------------------------------------

if {[sizeof_collection [get_ports -quiet VDD]] == 0} {
    create_port -direction inout VDD
} else {
    puts "VDD port already exists"
}

if {[sizeof_collection [get_ports -quiet VSS]] == 0} {
    create_port -direction inout VSS
} else {
    puts "VSS port already exists"
}

# ------------------------------------------------------------
# LOGICAL PG CONNECTIONS
# SAED32 reference lines 15-30
# ------------------------------------------------------------

connect_pg_net -net VDD [get_ports VDD]
connect_pg_net -net VSS [get_ports VSS]

connect_pg_net -net VDD [get_pins -physical_context */VDD]
connect_pg_net -net VSS [get_pins -physical_context */VSS]

connect_pg_net -automatic

puts "VDD physical cell pins:"
puts [sizeof_collection [get_pins -physical_context */VDD]]

puts "VSS physical cell pins:"
puts [sizeof_collection [get_pins -physical_context */VSS]]

# ------------------------------------------------------------
# SAED32 REFERENCE TOP PG MESH
#
# M9 horizontal
# M8 vertical
# width  = 0.16
# pitch  = 4
# offset = 1.6
# ------------------------------------------------------------

create_pg_mesh_pattern P_top_two \
    -layers { \
        { \
            {horizontal_layer: M9} \
            {width: 0.16} \
            {spacing: interleaving} \
            {pitch: 4} \
            {offset: 1.6} \
            {trim: true} \
        } \
        { \
            {vertical_layer: M8} \
            {width: 0.16} \
            {spacing: interleaving} \
            {pitch: 4} \
            {offset: 1.6} \
            {trim: true} \
        } \
    }

set_pg_strategy S_default_vddvss \
    -core \
    -pattern {{name: P_top_two} {nets: {VSS VDD}}} \
    -extension {{{stop: design_boundary_and_generate_pin}}}

puts "============================================================"
puts " COMPILING SAED32 M8/M9 PG MESH"
puts "============================================================"

compile_pg -strategies {S_default_vddvss}

# ------------------------------------------------------------
# SAED32 REFERENCE STANDARD-CELL RAILS
#
# Reference rail width = 0.094 um
# ------------------------------------------------------------

create_pg_std_cell_conn_pattern std_rail_conn1 \
    -layers M1

set_pg_strategy std_rail_1 \
    -pattern {{name: std_rail_conn1} {nets: {VDD VSS}}} \
    -core

puts "============================================================"
puts " COMPILING SAED32 M1 STANDARD-CELL RAILS"
puts "============================================================"

compile_pg -strategies {std_rail_1}

# ------------------------------------------------------------
# REASSERT LOGICAL PG CONNECTION
# ------------------------------------------------------------

connect_pg_net -net VDD [get_ports VDD]
connect_pg_net -net VSS [get_ports VSS]

connect_pg_net -net VDD [get_pins -physical_context */VDD]
connect_pg_net -net VSS [get_pins -physical_context */VSS]

connect_pg_net -automatic

# ------------------------------------------------------------
# CONNECTIVITY / DRC
# ------------------------------------------------------------

redirect -file ./stage05/reports/pg_reference_connectivity.rpt {
    check_pg_connectivity \
        -nets {VDD VSS} \
        -check_std_cell_pins all \
        -write_connectivity_file \
        ./stage05/reports/pg_reference_connectivity_detail.txt
}

redirect -file ./stage05/reports/pg_reference_drc.rpt {
    check_pg_drc -nets {VDD VSS}
}

# ------------------------------------------------------------
# SAVE TEST CHECKPOINT
# ------------------------------------------------------------

save_block -as ${TOP}/placed_pg_reference
save_lib

puts ""
puts "============================================================"
puts " SAED32 REFERENCE PG REBUILD COMPLETE"
puts "============================================================"
puts ""

exit

