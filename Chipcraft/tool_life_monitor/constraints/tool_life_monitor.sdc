# ============================================================
# Tool Life Monitor - Timing Constraints
# ============================================================

# Main RTL clock
# 100 MHz = 10 ns period
create_clock -name CLK -period 10.0 [get_ports clk]

# Clock uncertainty
set_clock_uncertainty 0.20 [get_clocks CLK]

# Input delay
set_input_delay 1.0 \
    -clock CLK \
    [remove_from_collection [all_inputs] [get_ports clk]]

# Output delay
set_output_delay 1.0 \
    -clock CLK \
    [all_outputs]

# Treat reset as asynchronous control, not timed data input
set_false_path -from [get_ports rst_n]
