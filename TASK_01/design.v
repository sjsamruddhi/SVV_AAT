// design.sv
typedef enum logic [1:0] {
    ADD = 2'b00,
    SUB = 2'b01,
    MUL = 2'b10,
    XOR = 2'b11
} alu_op_t;

module alu (
    input  logic [7:0]  a,
    input  logic [7:0]  b,
    input  alu_op_t     op,
    output logic [15:0] result
);

    always_comb begin
        case (op)
            ADD: result = a + b;
            SUB: result = a - b;
            MUL: result = a * b;
            XOR: result = a ^ b;
            default: result = 16'd0;
        endcase
    end

endmodule
