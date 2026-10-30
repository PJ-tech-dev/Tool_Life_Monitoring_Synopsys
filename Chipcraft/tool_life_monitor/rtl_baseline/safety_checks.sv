module safety_checks (
    input  logic [15:0] threshold [0:3],
    input  logic [15:0] count     [0:3],

    output logic [3:0] invalid_threshold,
    output logic [3:0] counter_max
);

    integer i;

    always_comb begin
        for (i = 0; i < 4; i = i + 1) begin
            invalid_threshold[i] = (threshold[i] == 16'd0);
            counter_max[i]       = (count[i] == 16'hFFFF);
        end
    end

endmodule
