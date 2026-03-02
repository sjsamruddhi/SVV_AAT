`timescale 1ns/1ps

interface clock_if (input logic clk);

    logic rst;
    logic [5:0] sec;
    logic [5:0] min;

    // DUT side
    modport DUT (
        input  clk, rst,
        output sec, min
    );

    // Testbench side
    modport TB (
        input  clk,
        output rst,
        input  sec, min
    );

endinterface
