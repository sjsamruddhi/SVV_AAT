`timescale 1ns/1ps

module clock_tb;

    logic clk;

    // Interface instance
    clock_if vif(clk);

    // DUT instance
    digital_clock dut (
        .clk (vif.clk),
        .rst (vif.rst),
        .sec (vif.sec),
        .min (vif.min)
    );

    // Test instance
    clock_test test (vif);

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Dump waveform
    initial begin
        $dumpfile("clock_wave.vcd");
        $dumpvars(0, clock_tb);
    end

endmodule
