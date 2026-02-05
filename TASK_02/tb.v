`timescale 1ns/1ps

module tb;

    logic clk;
    logic rst;
    logic [5:0] sec;
    logic [5:0] min;

    // DUT
    digital_clock dut (
        .clk(clk),
        .rst(rst),
        .sec(sec),
        .min(min)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    // ----------------------------
    // Coverage
    // ----------------------------
    covergroup cg @(posedge clk);

        // Detect second wrap 59 -> 0
        sec_transition: coverpoint sec {
            bins wrap = (6'd59 => 6'd0);
        }

        // Track minute values
        min_value: coverpoint min {
            bins min_vals[] = {[0:59]};
        }

        // Cross: minute should increment on sec wrap
        sec_wrap_min_inc: cross sec_transition, min_value;

    endgroup

    cg cov = new();

    // ----------------------------
    // Test
    // ----------------------------
    initial begin
        // EPWave / VCD dump
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);

        clk = 0;
        rst = 1;

        #12 rst = 0;

        // Run long enough to see multiple wraps
        repeat (130) begin
            @(posedge clk);
            cov.sample();
        end

        $display("Coverage = %0.2f %%", cov.get_coverage());
        $finish;
    end

endmodule
