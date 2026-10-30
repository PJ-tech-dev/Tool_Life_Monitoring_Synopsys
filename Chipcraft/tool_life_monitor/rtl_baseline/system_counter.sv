module system_counter (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [3:0]  cycle_event,
    input  logic [3:0]  counter_reset,
    output logic [15:0] count [0:3]
);

    integer i;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 4; i = i + 1)
                count[i] <= 16'd0;
        end
        else begin
            for (i = 0; i < 4; i = i + 1) begin

                if (counter_reset[i]) begin
                    count[i] <= 16'd0;
                end
                else if (cycle_event[i]) begin
                    if (count[i] != 16'hFFFF)
                        count[i] <= count[i] + 16'd1;
                end

            end
        end
    end

endmodule
