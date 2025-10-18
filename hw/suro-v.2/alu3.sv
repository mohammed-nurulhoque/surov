module alu3 #(
    parameter int WIDTH = 32,
    parameter int WSHAM = $clog2(WIDTH)
) (
    input logic clk,
    input logic start,

    input logic[WIDTH-1:0] src_a,
    input logic[WIDTH-1:0] src_b,
    input logic[2:0] f3,
    input logic arith_bit,
`ifdef SHADD
    input logic shadd,
`endif
    input logic branch,

    output logic[WIDTH-1:0] out,
    output logic[WSHAM-1:0] shamt_out,
    output logic done
);
    logic is_pure_shift;
    logic is_right_shift;
    logic is_pure_alu;
    logic is_logical;

    always_comb begin
`ifdef SHADD
        is_pure_alu = !shadd && !branch;
`else
        is_pure_alu = !branch;
`endif
        is_pure_shift = is_pure_alu && (f3 == FUNC_SLL || f3 == FUNC_SR);
        is_right_shift = f3 == FUNC_SR;
        is_logical = is_pure_alu && (f3 == FUNC_AND || f3 == FUNC_OR || f3 == FUNC_XOR);
    end

    typedef logic[WSHAM-1:0] shamt_t;
    shamt_t shamt;
    word_t shifter_out;
    logic shifter_done;
    
    always_comb begin
        shamt = 0;
`ifdef SHADD
        if (shadd) shamt = shamt_t'(f3[2:1]);
        else
`endif
        if (is_pure_shift) shamt = src_b[4:0];
    end

    shifter3 #(WIDTH) S (
        .clk(clk),
        .start(start),
        .val_i(src_a),
        .sham_i(shamt),
        .right_shift(is_right_shift),
        .arith_shift(arith_bit),
        .val_o(shifter_out),
        .sham_o(shamt_out)
    );

    logic adder_cout;
    adderOp_t adder_op;
    word_t adder_out;

    always_comb begin
`ifdef SHADD
        if (shadd) adder_op = ADDER_ADD;
        else
`endif
        if (branch) adder_op = adderOp_t'(f3);
        else unique case (f3)
            FUNC_ADDSUB: adder_op = arith_bit ? ADDER_SUB : ADDER_ADD;
            FUNC_SLT: adder_op = ADDER_LT;
            FUNC_SLTU: adder_op = ADDER_LTU;
            default: adder_op = adderOp_t'('X);
        endcase
    end
    adder A (
        .op(adder_op),
        .src_a(src_a),
        .src_b(src_b),
        .out(adder_out),
        .cout(adder_cout)
    );

    always_comb begin
        unique case (1'b1)
            is_pure_shift: done = shamt_out == 0;
`ifdef SHADD
            shadd: done = !start;
`endif
            default: done = 1'b1;
        endcase
    end

    always_comb begin
        out = adder_out;
        if (is_pure_shift
`ifdef SHADD
             || (shadd && start)
`endif
            ) out = shifter_out;
        if (is_logical) begin
            unique case (f3)
                FUNC_AND: out = src_a & src_b;
                FUNC_OR:  out = src_a | src_b;
                FUNC_XOR: out = src_a ^ src_b;
                default: out = adder_out;
            endcase
        end
    end
endmodule