module readback_logic (
    input  logic [1:0]  system_sel,

    input  logic [15:0] count     [0:3],
    input  logic [15:0] threshold [0:3],
    input  logic [1:0]  status    [0:3],

    output logic [15:0] selected_count,
    output logic [15:0] selected_threshold,
    output logic [1:0]  selected_status
);

    always_comb begin
        selected_count     = count[system_sel];
        selected_threshold = threshold[system_sel];
        selected_status    = status[system_sel];
    end

endmodule
