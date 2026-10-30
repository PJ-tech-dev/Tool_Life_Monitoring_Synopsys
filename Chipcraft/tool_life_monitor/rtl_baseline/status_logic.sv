module status_logic (
    input  logic [15:0] count             [0:3],
    input  logic [15:0] threshold         [0:3],
    input  logic [3:0]  invalid_threshold,

    output logic [1:0]  status            [0:3],
    output logic [3:0]  warning,
    output logic [3:0]  replacement_req
);

    localparam logic [1:0] STATUS_SAFE    = 2'b00;
    localparam logic [1:0] STATUS_NEAR    = 2'b01;
    localparam logic [1:0] STATUS_REPLACE = 2'b10;

    integer i;

    logic [18:0] count_x5;
    logic [18:0] threshold_x4;

    always_comb begin

        warning         = 4'b0000;
        replacement_req = 4'b0000;

        for (i = 0; i < 4; i = i + 1) begin

            status[i] = STATUS_SAFE;

            // 5 × count using shift + add
            count_x5 = {3'b000, count[i]}
                     + ({3'b000, count[i]} << 2);

            // 4 × threshold using shift
            threshold_x4 = ({3'b000, threshold[i]} << 2);

            if (!invalid_threshold[i]) begin

                if (count[i] >= threshold[i]) begin
                    status[i]          = STATUS_REPLACE;
                    replacement_req[i] = 1'b1;
                end

                else if (count_x5 >= threshold_x4) begin
                    status[i]  = STATUS_NEAR;
                    warning[i] = 1'b1;
                end

                else begin
                    status[i] = STATUS_SAFE;
                end

            end

        end

    end

endmodule
