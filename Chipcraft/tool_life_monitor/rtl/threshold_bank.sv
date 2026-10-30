module threshold_bank (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [1:0]  system_sel,
    input  logic [15:0] threshold_data,
    input  logic        threshold_we,
    output logic [15:0] threshold [0:3]
);

    integer i;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 4; i = i + 1)
                threshold[i] <= 16'd0;
        end
        else if (threshold_we) begin
            threshold[system_sel] <= threshold_data;
        end
    end

endmodule
