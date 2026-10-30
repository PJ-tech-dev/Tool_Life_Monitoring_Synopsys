task automatic set_threshold(
    input logic [1:0]  sys,
    input logic [15:0] value
);
begin
    @(negedge clk);
    system_sel     = sys;
    threshold_data = value;
    threshold_we   = 1'b1;

    @(negedge clk);
    threshold_we   = 1'b0;
end
endtask


task automatic send_cycles(
    input logic [3:0] machine_mask,
    input integer     num_cycles
);
    integer j;
begin
    for (j = 0; j < num_cycles; j = j + 1) begin
        @(negedge clk);
        cycle_event = machine_mask;

        @(negedge clk);
        cycle_event = 4'b0000;
    end
end
endtask


task automatic acknowledge_replacement(
    input logic [3:0] machine_mask
);
begin
    @(negedge clk);
    replace_ack = machine_mask;

    @(negedge clk);
    replace_ack = 4'b0000;
end
endtask


task automatic select_system(
    input logic [1:0] sys
);
begin
    @(negedge clk);
    system_sel = sys;
end
endtask
