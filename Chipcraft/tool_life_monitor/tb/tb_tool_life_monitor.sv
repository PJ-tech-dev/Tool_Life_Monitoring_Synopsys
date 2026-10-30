`timescale 1ns/1ps

module tb_tool_life_monitor;

    // ================================================================
    // INPUTS
    // ================================================================

    logic        clk;
    logic        rst_n;

    logic [3:0]  cycle_event;

    logic [1:0]  system_sel;
    logic [15:0] threshold_data;
    logic        threshold_we;

    logic [3:0]  replace_ack;


    // ================================================================
    // OUTPUTS
    // ================================================================

    logic [3:0]  warning;
    logic [3:0]  replacement_req;
    logic [3:0]  invalid_threshold;
    logic [3:0]  counter_max;

    logic [15:0] selected_count;
    logic [15:0] selected_threshold;
    logic [1:0]  selected_status;


    // ================================================================
    // GTKWave visible signals
    // ================================================================

    logic [15:0] count0;
    logic [15:0] count1;
    logic [15:0] count2;
    logic [15:0] count3;

    logic [15:0] threshold0;
    logic [15:0] threshold1;
    logic [15:0] threshold2;
    logic [15:0] threshold3;

    logic [1:0] status0;
    logic [1:0] status1;
    logic [1:0] status2;
    logic [1:0] status3;

    logic [3:0] counter_reset_view;


    // ================================================================
    // DUT
    // ================================================================

    tool_life_monitor_top dut (
        .clk                (clk),
        .rst_n              (rst_n),

        .cycle_event        (cycle_event),

        .system_sel         (system_sel),
        .threshold_data     (threshold_data),
        .threshold_we       (threshold_we),

        .replace_ack        (replace_ack),

        .warning            (warning),
        .replacement_req    (replacement_req),
        .invalid_threshold  (invalid_threshold),
        .counter_max        (counter_max),

        .selected_count     (selected_count),
        .selected_threshold (selected_threshold),
        .selected_status    (selected_status)
    );


    // ================================================================
    // Expose DUT internal signals to GTKWave
    // ================================================================

    assign count0 = dut.count[0];
    assign count1 = dut.count[1];
    assign count2 = dut.count[2];
    assign count3 = dut.count[3];

    assign threshold0 = dut.threshold[0];
    assign threshold1 = dut.threshold[1];
    assign threshold2 = dut.threshold[2];
    assign threshold3 = dut.threshold[3];

    assign status0 = dut.status[0];
    assign status1 = dut.status[1];
    assign status2 = dut.status[2];
    assign status3 = dut.status[3];

    assign counter_reset_view = dut.counter_reset;


    // ================================================================
    // CLOCK
    // 100 MHz -> 10 ns period
    // ================================================================

    initial clk = 1'b0;

    always #5 clk = ~clk;


    // ================================================================
    // VCD
    // ================================================================

    initial begin
        $dumpfile("sim/waves/tool_life_monitor.vcd");
        $dumpvars(0, tb_tool_life_monitor);
    end


    // ================================================================
    // TASK : PROGRAM THRESHOLD
    // ================================================================

    task automatic program_threshold(
        input logic [1:0]  machine,
        input logic [15:0] value
    );
    begin

        @(negedge clk);

        system_sel     = machine;
        threshold_data = value;
        threshold_we   = 1'b1;

        @(negedge clk);

        threshold_we   = 1'b0;

    end
    endtask


    // ================================================================
    // TASK : GENERATE MACHINE CYCLES
    // ================================================================

    task automatic generate_cycles(
        input logic [3:0] machine_mask,
        input integer     number_of_cycles
    );

        integer j;

    begin

        for (j = 0; j < number_of_cycles; j = j + 1) begin

            @(negedge clk);
            cycle_event = machine_mask;

            @(negedge clk);
            cycle_event = 4'b0000;

        end

    end
    endtask


    // ================================================================
    // TASK : ACKNOWLEDGE REPLACEMENT
    // ================================================================

    task automatic acknowledge_machine(
        input logic [3:0] machine_mask
    );
    begin

        // Wait until this machine actually requests replacement
        wait ((replacement_req & machine_mask) != 4'b0000);

        @(negedge clk);

        replace_ack = machine_mask;

        // Hold ACK across active clock edge
        @(posedge clk);

        #1;

        @(negedge clk);

        replace_ack = 4'b0000;

        #2;

    end
    endtask


    // ================================================================
    // MAIN TEST
    // ================================================================

    initial begin

        // ------------------------------------------------------------
        // INITIAL VALUES
        // ------------------------------------------------------------

        rst_n          = 1'b0;
        cycle_event    = 4'b0000;
        system_sel     = 2'b00;
        threshold_data = 16'd0;
        threshold_we   = 1'b0;
        replace_ack    = 4'b0000;


        // ============================================================
        // TEST 1 : GLOBAL RESET
        // ============================================================

        repeat (3) @(posedge clk);

        @(negedge clk);
        rst_n = 1'b1;

        #2;

        $display("");
        $display("===============================================");
        $display("TEST 1 : GLOBAL RESET");
        $display("===============================================");

        $display("Counts = %0d %0d %0d %0d",
                 count0, count1, count2, count3);

        $display("Invalid threshold = %b", invalid_threshold);


        // ============================================================
        // TEST 2 : PROGRAM ALL THRESHOLDS
        // ============================================================

        program_threshold(2'd0, 16'd10);
        program_threshold(2'd1, 16'd15);
        program_threshold(2'd2, 16'd20);
        program_threshold(2'd3, 16'd25);

        #2;

        $display("");
        $display("===============================================");
        $display("TEST 2 : THRESHOLD PROGRAMMING");
        $display("===============================================");

        $display("Machine 0 threshold = %0d", threshold0);
        $display("Machine 1 threshold = %0d", threshold1);
        $display("Machine 2 threshold = %0d", threshold2);
        $display("Machine 3 threshold = %0d", threshold3);

        $display("Invalid threshold = %b", invalid_threshold);


        // ============================================================
        // TEST 3 : DRIVE ALL MACHINES TO 80% WARNING
        // ============================================================

        // M0 : 80% of 10 = 8
        generate_cycles(4'b0001, 8);

        // M1 : 80% of 15 = 12
        generate_cycles(4'b0010, 12);

        // M2 : 80% of 20 = 16
        generate_cycles(4'b0100, 16);

        // M3 : 80% of 25 = 20
        generate_cycles(4'b1000, 20);

        #2;

        $display("");
        $display("===============================================");
        $display("TEST 3 : ALL MACHINES AT WARNING LEVEL");
        $display("===============================================");

        $display("Counts  = %0d %0d %0d %0d",
                 count0, count1, count2, count3);

        $display("Warning = %b", warning);

        if (warning !== 4'b1111)
            $error("ERROR: Expected warning = 1111");


        // ============================================================
        // TEST 4 : MACHINE 0 REACHES REPLACEMENT LIMIT
        // ============================================================

        generate_cycles(4'b0001, 2);

        #2;

        $display("");
        $display("Machine 0 reached threshold");
        $display("count0 = %0d", count0);
        $display("replacement_req = %b", replacement_req);

        if (replacement_req[0] !== 1'b1)
            $error("Machine 0 replacement flag failed");


        // ============================================================
        // TEST 5 : MACHINE 1 REACHES REPLACEMENT LIMIT
        // ============================================================

        generate_cycles(4'b0010, 3);

        #2;

        $display("");
        $display("Machine 1 reached threshold");
        $display("count1 = %0d", count1);
        $display("replacement_req = %b", replacement_req);

        if (replacement_req[1] !== 1'b1)
            $error("Machine 1 replacement flag failed");


        // ============================================================
        // TEST 6 : MACHINE 2 REACHES REPLACEMENT LIMIT
        // ============================================================

        generate_cycles(4'b0100, 4);

        #2;

        $display("");
        $display("Machine 2 reached threshold");
        $display("count2 = %0d", count2);
        $display("replacement_req = %b", replacement_req);

        if (replacement_req[2] !== 1'b1)
            $error("Machine 2 replacement flag failed");


        // ============================================================
        // TEST 7 : MACHINE 3 REACHES REPLACEMENT LIMIT
        // ============================================================

        generate_cycles(4'b1000, 5);

        #2;

        $display("");
        $display("Machine 3 reached threshold");
        $display("count3 = %0d", count3);
        $display("replacement_req = %b", replacement_req);

        if (replacement_req[3] !== 1'b1)
            $error("Machine 3 replacement flag failed");


        // ------------------------------------------------------------
        // At this point ALL FOUR should request replacement
        // ------------------------------------------------------------

        #5;

        $display("");
        $display("===============================================");
        $display("TEST 8 : ALL REPLACEMENT FLAGS HIGH");
        $display("===============================================");

        $display("replacement_req = %b", replacement_req);

        if (replacement_req !== 4'b1111)
            $error("ERROR: Expected replacement_req = 1111");


        // ============================================================
        // TEST 9 : ACKNOWLEDGE MACHINE 0
        // ============================================================

        acknowledge_machine(4'b0001);

        $display("");
        $display("Machine 0 acknowledged");
        $display("count0 = %0d", count0);
        $display("replacement_req = %b", replacement_req);

        if (count0 !== 16'd0)
            $error("Machine 0 reset failed");


        // ============================================================
        // TEST 10 : ACKNOWLEDGE MACHINE 1
        // ============================================================

        acknowledge_machine(4'b0010);

        $display("");
        $display("Machine 1 acknowledged");
        $display("count1 = %0d", count1);
        $display("replacement_req = %b", replacement_req);

        if (count1 !== 16'd0)
            $error("Machine 1 reset failed");


        // ============================================================
        // TEST 11 : ACKNOWLEDGE MACHINE 2
        // ============================================================

        acknowledge_machine(4'b0100);

        $display("");
        $display("Machine 2 acknowledged");
        $display("count2 = %0d", count2);
        $display("replacement_req = %b", replacement_req);

        if (count2 !== 16'd0)
            $error("Machine 2 reset failed");


        // ============================================================
        // TEST 12 : ACKNOWLEDGE MACHINE 3
        // ============================================================

        acknowledge_machine(4'b1000);

        $display("");
        $display("Machine 3 acknowledged");
        $display("count3 = %0d", count3);
        $display("replacement_req = %b", replacement_req);

        if (count3 !== 16'd0)
            $error("Machine 3 reset failed");


        // ============================================================
        // TEST 13 : ALL MACHINES SHOULD NOW BE RESET
        // ============================================================

        #5;

        $display("");
        $display("===============================================");
        $display("TEST 13 : ALL TOOLS REPLACED");
        $display("===============================================");

        $display("Counts = %0d %0d %0d %0d",
                 count0, count1, count2, count3);

        $display("replacement_req = %b", replacement_req);
        $display("warning         = %b", warning);

        if ((count0 != 0) ||
            (count1 != 0) ||
            (count2 != 0) ||
            (count3 != 0))
            $error("ERROR: Not all counters reset");

        if (replacement_req !== 4'b0000)
            $error("ERROR: Replacement flags did not clear");


        // ============================================================
        // TEST 14 : NEW TOOLS START COUNTING AGAIN
        // ============================================================

        generate_cycles(4'b0001, 2);
        generate_cycles(4'b0010, 3);
        generate_cycles(4'b0100, 4);
        generate_cycles(4'b1000, 5);

        #2;

        $display("");
        $display("===============================================");
        $display("TEST 14 : COUNTING AFTER REPLACEMENT");
        $display("===============================================");

        $display("Machine 0 = %0d", count0);
        $display("Machine 1 = %0d", count1);
        $display("Machine 2 = %0d", count2);
        $display("Machine 3 = %0d", count3);

        if (count0 !== 16'd2)
            $error("Machine 0 recount failed");

        if (count1 !== 16'd3)
            $error("Machine 1 recount failed");

        if (count2 !== 16'd4)
            $error("Machine 2 recount failed");

        if (count3 !== 16'd5)
            $error("Machine 3 recount failed");


        // ============================================================
        // TEST 15 : SIMULTANEOUS OPERATION
        // ============================================================

        generate_cycles(4'b1111, 1);

        #2;

        $display("");
        $display("===============================================");
        $display("TEST 15 : SIMULTANEOUS MACHINE OPERATION");
        $display("===============================================");

        $display("Machine 0 = %0d", count0);
        $display("Machine 1 = %0d", count1);
        $display("Machine 2 = %0d", count2);
        $display("Machine 3 = %0d", count3);

        // Expected:
        // M0 2 -> 3
        // M1 3 -> 4
        // M2 4 -> 5
        // M3 5 -> 6

        if (count0 !== 16'd3)
            $error("Machine 0 simultaneous test failed");

        if (count1 !== 16'd4)
            $error("Machine 1 simultaneous test failed");

        if (count2 !== 16'd5)
            $error("Machine 2 simultaneous test failed");

        if (count3 !== 16'd6)
            $error("Machine 3 simultaneous test failed");


        // ============================================================
        // TEST 16 : READBACK
        // ============================================================

        @(negedge clk);
        system_sel = 2'd0;
        #2;

        $display("Read M0 : Count=%0d Threshold=%0d Status=%b",
                 selected_count,
                 selected_threshold,
                 selected_status);


        @(negedge clk);
        system_sel = 2'd1;
        #2;

        $display("Read M1 : Count=%0d Threshold=%0d Status=%b",
                 selected_count,
                 selected_threshold,
                 selected_status);


        @(negedge clk);
        system_sel = 2'd2;
        #2;

        $display("Read M2 : Count=%0d Threshold=%0d Status=%b",
                 selected_count,
                 selected_threshold,
                 selected_status);


        @(negedge clk);
        system_sel = 2'd3;
        #2;

        $display("Read M3 : Count=%0d Threshold=%0d Status=%b",
                 selected_count,
                 selected_threshold,
                 selected_status);


        // ============================================================
        // END
        // ============================================================

        #50;

        $display("");
        $display("===============================================");
        $display("ALL FUNCTIONAL TESTS COMPLETED");
        $display("===============================================");

        $finish;

    end

endmodule
