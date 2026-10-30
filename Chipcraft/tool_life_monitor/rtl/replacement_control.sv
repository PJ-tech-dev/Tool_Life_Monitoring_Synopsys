module replacement_control (
    input  logic [3:0] replacement_req,
    input  logic [3:0] replace_ack,

    output logic [3:0] counter_reset
);

    always_comb begin
        counter_reset = replacement_req & replace_ack;
    end

endmodule
