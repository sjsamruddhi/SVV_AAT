// testbench.sv
`timescale 1ns/1ps

// Transaction
class alu_transaction;
    rand logic [7:0] a;
    rand logic [7:0] b;
    rand alu_op_t    op;

    // Opcode distribution
    constraint op_dist {
        op dist {
            ADD := 25,
            SUB := 25,
            MUL := 20,
            XOR := 30
        };
    }
endclass


module tb;

    alu_transaction tr;

    logic [7:0]  a;
    logic [7:0]  b;
    alu_op_t     op;
    logic [15:0] result;

    // DUT
    alu dut (
        .a      (a),
        .b      (b),
        .op     (op),
        .result (result)
    );

    // Coverage
    covergroup alu_cg @(posedge tb_clk);
        coverpoint op;
    endgroup

    // Simple sampling clock
    logic tb_clk = 0;
    always #1 tb_clk = ~tb_clk;

    alu_cg cg = new();

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb);

        tr = new();

        repeat (100) begin
            assert(tr.randomize());

            a  = tr.a;
            b  = tr.b;
            op = tr.op;

            #1;
            cg.sample();
        end

        $display("Opcode Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
