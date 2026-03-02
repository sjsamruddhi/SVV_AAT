`timescale 1ns/1ps

program clock_test (clock_if.TB vif);

    // -------------------------------
    // COVERAGE
    // -------------------------------
    covergroup cg @(posedge vif.clk);

        cp_sec : coverpoint vif.sec {
            bins sec_vals[] = {[0:59]};
            bins sec_rollover = (59 => 0);
        }

        cp_min : coverpoint vif.min {
            bins min_vals[] = {[0:59]};
            bins min_rollover = (59 => 0);
        }

        cross cp_sec, cp_min;

    endgroup

    cg cov = new();

    // -------------------------------
    // ASSERTIONS
    // -------------------------------
    property sec_limit;
        @(posedge vif.clk)
        vif.sec <= 6'd59;
    endproperty

    property min_limit;
        @(posedge vif.clk)
        vif.min <= 6'd59;
    endproperty

    assert property (sec_limit)
        else $error("Seconds exceeded 59");

    assert property (min_limit)
        else $error("Minutes exceeded 59");


    // -------------------------------
    // TEST SEQUENCE
    // -------------------------------
    initial begin

        // Initial reset
        vif.rst = 1;
        repeat (2) @(posedge vif.clk);
        vif.rst = 0;

        // Run long enough to hit all bins
        repeat (3700) @(posedge vif.clk);

        // Mid simulation reset (visible in waveform)
        vif.rst = 1;
        repeat (2) @(posedge vif.clk);
        vif.rst = 0;

        // Additional cycles
        repeat (200) @(posedge vif.clk);

        $display("Simulation Completed Successfully");
        $finish;
    end

endprogram
