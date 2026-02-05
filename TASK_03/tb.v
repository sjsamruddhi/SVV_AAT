`timescale 1ns/1ps

module tb;

    logic clk;

    // Port A
    logic we_a;
    logic [3:0] addr_a;
    logic [7:0] data_a;

    // Port B
    logic re_b;
    logic [3:0] addr_b;
    logic [7:0] data_b;

    // DUT
    dual_port_ram dut (
        .clk(clk),
        .we_a(we_a),
        .addr_a(addr_a),
        .data_a(data_a),
        .re_b(re_b),
        .addr_b(addr_b),
        .data_b(data_b)
    );

    // Clock generation (10 ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    // Dump for EPWave / GTKWave
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // Test stimulus
    initial begin
        // Init
        we_a  = 0;
        re_b  = 0;
        addr_a = 0;
        addr_b = 0;
        data_a = 0;

        // Write data
        @(posedge clk);
        we_a  = 1;
        addr_a = 4'd3;
        data_a = 8'hAA;

        @(posedge clk);
        addr_a = 4'd7;
        data_a = 8'h55;

        @(posedge clk);
        we_a = 0;

        // Read data
        @(posedge clk);
        re_b  = 1;
        addr_b = 4'd3;

        @(posedge clk);
        addr_b = 4'd7;

        @(posedge clk);
        re_b = 0;

        #20;
        $finish;
    end

endmodule
