`timescale 1ns/1ps

module tb;

    logic clk = 0;

    // DUT signals
    logic we_a;
    logic re_b;
    logic [3:0] addr_a;
    logic [3:0] addr_b;
    logic [7:0] data_a;
    logic [7:0] data_b;

    // DUT instantiation
    dual_port_ram dut (
        .clk   (clk),
        .we_a  (we_a),
        .addr_a(addr_a),
        .data_a(data_a),
        .re_b  (re_b),
        .addr_b(addr_b),
        .data_b(data_b)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // EPWave dump
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
        $dumpvars(0, dut);

        // Initialize
        we_a   = 0;
        re_b   = 0;
        addr_a = 0;
        addr_b = 0;
        data_a = 0;

        // ---- WRITE OPERATIONS ----
        @(posedge clk);
        we_a   = 1;
        addr_a = 4'd3;
        data_a = 8'hAA;

        @(posedge clk);
        addr_a = 4'd5;
        data_a = 8'h55;

        @(posedge clk);
        we_a = 0;

        // ---- READ OPERATIONS ----
        @(posedge clk);
        re_b   = 1;
        addr_b = 4'd3;

        @(posedge clk);
        addr_b = 4'd5;

        @(posedge clk);
        re_b = 0;

        #20;
        $finish;
    end

endmodule
