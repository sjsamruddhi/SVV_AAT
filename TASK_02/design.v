// design.sv
module digital_clock (
    input  logic        clk,
    input  logic        rst,
    output logic [5:0]  sec,
    output logic [5:0]  min
);

    always_ff @(posedge clk or posedge rst) begin
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
