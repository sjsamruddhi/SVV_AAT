`timescale 1ns/1ps

module dual_port_ram #(
    parameter ADDR_WIDTH = 4,   // 16 locations
    parameter DATA_WIDTH = 8
)(
    input  logic clk,

    // Port A : Write
    input  logic                  we_a,
    input  logic [ADDR_WIDTH-1:0] addr_a,
    input  logic [DATA_WIDTH-1:0] data_a,

    // Port B : Read
    input  logic                  re_b,
    input  logic [ADDR_WIDTH-1:0] addr_b,
    output logic [DATA_WIDTH-1:0] data_b
);

    // Memory array
    logic [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    // Write port (A)
    always_ff @(posedge clk) begin
        if (we_a)
            mem[addr_a] <= data_a;
    end

    // Read port (B) – synchronous read
    always_ff @(posedge clk) begin
        if (re_b)
            data_b <= mem[addr_b];
    end

endmodule
