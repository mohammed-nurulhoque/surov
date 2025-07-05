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
    input logic shadd,
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
        is_pure_alu = !shadd && !branch;
        is_pure_shift = is_pure_alu && (f3 == FUNC_SLL || f3 == FUNC_SR);
        is_right_shift = f3 == FUNC_SR;
        is_logical = is_pure_alu && (f3 == FUNC_AND || f3 == FUNC_OR || f3 == FUNC_XOR);
    end

    typedef logic[WSHAM-1:0] shamt_t;
    shamt_t shamt;
    word_t shifter_to_adder;
    logic shifter_done;
    
    always_comb begin
        shamt = 0;
        if (shadd) shamt = shamt_t'(f3[2:1]);
        else if (is_pure_shift) shamt = src_b[4:0];
    end

    shifter3 #(WIDTH) S (
        .clk(clk),
        .start(start),
        .val_i(src_a),
        .sham_i(shamt),
        .right_shift(is_right_shift),
        .arith_shift(arith_bit),
        .val_o(shifter_to_adder),
        .sham_o(shamt_out)
    );

    logic adder_cout;
    adderOp_t adder_op;
    word_t adder_src_b;
    assign adder_src_b = (is_pure_shift || is_logical) ? 0 : src_b;
    word_t adder_out;

    always_comb begin
        adder_op = ADDER_ADD;
        if (!shadd) begin
            if (branch) case (f3)
                BR_NE: adder_op = ADDER_NE;
                BR_EQ: adder_op = ADDER_EQ;
                BR_LT: adder_op = ADDER_LT;
                BR_GE: adder_op = ADDER_GE;
                BR_LTU: adder_op = ADDER_LTU;
                BR_GEU: adder_op = ADDER_GEU;
            endcase
            else case (f3)
                FUNC_ADDSUB: adder_op = arith_bit ? ADDER_SUB : ADDER_ADD;
                FUNC_SLT: adder_op = ADDER_LT;
                FUNC_SLTU: adder_op = ADDER_LTU;
            endcase
        end
    end
    adder #(WIDTH) A (
        .op(adder_op),
        .src_a(shifter_to_adder),
        .src_b(adder_src_b),
        .out(adder_out),
        .cout(adder_cout)
    );

    always_comb begin
        done = is_pure_shift? shamt_out == 0: 1'b1;
        out = adder_out;
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