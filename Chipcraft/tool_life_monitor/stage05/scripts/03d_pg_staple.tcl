
set TOP "tool_life_monitor_top"
set DESIGN_LIB "./stage05/work/tool_life_monitor.nlib"

puts "============================================================"
puts " POST-PLACEMENT PG STAPLING"
puts "============================================================"

# Start from the clean successful placement.
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

puts "VDD physical pins = [sizeof_collection [get_pins -physical_context */VDD]]"
puts "VSS physical pins = [sizeof_collection [get_pins -physical_context */VSS]]"

# ------------------------------------------------------------
# EXISTING PG SHAPES
#
# M1 : standard-cell follow-pin rails
# M8 : vertical core mesh/ring shapes
# ------------------------------------------------------------

set M1_SHAPES [get_shapes -filter "layer_name == M1"]
set M8_SHAPES [get_shapes -filter "layer_name == M8"]

puts "M1 shapes = [sizeof_collection $M1_SHAPES]"
puts "M8 shapes = [sizeof_collection $M8_SHAPES]"

set CORE_BBOX [get_attribute [get_core_area] bbox]

# ------------------------------------------------------------
# STAPLE EXISTING M1 RAILS TO EXISTING M8 PG SHAPES
# ------------------------------------------------------------

puts "============================================================"
puts " CREATING M1 <-> M8 STAPLING VIAS"
puts "============================================================"

create_pg_stapling_vias \
    -nets {VDD VSS} \
    -from_layer M1 \
    -to_layer M8 \
    -from_shapes $M1_SHAPES \
    -to_shapes $M8_SHAPES \
    -regions $CORE_BBOX \
    -tag M1_M8_STAPLE

puts "============================================================"
puts " STAPLING VIA COUNT"
puts "============================================================"

set STAPLES [get_vias -filter is_via_staple]

puts "Number of stapling vias:"
puts [sizeof_collection $STAPLES]

# ------------------------------------------------------------
# CHECK CONNECTIVITY
# ------------------------------------------------------------

redirect -file ./stage05/reports/pg_connectivity_stapled.rpt {
    check_pg_connectivity \
        -nets {VDD VSS} \
        -check_std_cell_pins all \
        -write_connectivity_file ./stage05/reports/pg_connectivity_stapled_detail.txt
}

redirect -file ./stage05/reports/pg_drc_stapled.rpt {
    check_pg_drc -nets {VDD VSS}
}

# ------------------------------------------------------------
# SAVE
# ------------------------------------------------------------

save_block -as ${TOP}/placed_pg_stapled
save_lib

puts ""
puts "============================================================"
puts " PG STAPLING COMPLETE"
puts "============================================================"
puts ""

exit

