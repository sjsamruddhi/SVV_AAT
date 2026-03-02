`timescale 1ns/1ps

module digital_clock (
    input  logic        clk,
    input  logic        rst,          // active-high synchronous reset
    output logic [5:0]  sec,
    output logic [5:0]  min
);

    always_ff @(posedge clk) begin
        if (rst) begin
            sec <= 6'd0;
            min <= 6'd0;
        end
        else begin
            if (sec == 6'd59) begin
                sec <= 6'd0;

                if (min == 6'd59)
                    min <= 6'd0;
                else
                    min <= min + 1;
            end
            else begin
                sec <= sec + 1;
            end
        end
    end

endmodule
