module tool_life_monitor_top (
    input  logic        clk,
    input  logic        rst_n,

    input  logic [3:0]  cycle_event,

    input  logic [1:0]  system_sel,
    input  logic [15:0] threshold_data,
    input  logic        threshold_we,

    input  logic [3:0]  replace_ack,

    output logic [3:0]  warning,
    output logic [3:0]  replacement_req,
    output logic [3:0]  invalid_threshold,
    output logic [3:0]  counter_max,

    output logic [15:0] selected_count,
    output logic [15:0] selected_threshold,
    output logic [1:0]  selected_status
);

    logic [15:0] count     [0:3];
    logic [15:0] threshold [0:3];
    logic [1:0]  status    [0:3];

    logic [3:0] counter_reset;


    system_counter u_system_counter (
        .clk           (clk),
        .rst_n         (rst_n),
        .cycle_event   (cycle_event),
        .counter_reset (counter_reset),
        .count         (count)
    );


    threshold_bank u_threshold_bank (
        .clk            (clk),
        .rst_n          (rst_n),
        .system_sel     (system_sel),
        .threshold_data (threshold_data),
        .threshold_we   (threshold_we),
        .threshold      (threshold)
    );


    safety_checks u_safety_checks (
        .threshold         (threshold),
        .count             (count),
        .invalid_threshold (invalid_threshold),
        .counter_max       (counter_max)
    );


    status_logic u_status_logic (
        .count             (count),
        .threshold         (threshold),
        .invalid_threshold (invalid_threshold),
        .status            (status),
        .warning           (warning),
        .replacement_req   (replacement_req)
    );


    replacement_control u_replacement_control (
        .replacement_req (replacement_req),
        .replace_ack     (replace_ack),
        .counter_reset   (counter_reset)
    );


    readback_logic u_readback_logic (
        .system_sel         (system_sel),
        .count              (count),
        .threshold          (threshold),
        .status             (status),
        .selected_count     (selected_count),
        .selected_threshold (selected_threshold),
        .selected_status    (selected_status)
    );

endmodule
