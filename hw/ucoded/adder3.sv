// module adder #(
//     parameter int WIDTH = 16
// ) (
//     input logic[WIDTH-1:0] src_a,
//     input logic[WIDTH-1:0] src_b,
//     output logic[WIDTH-1:0] out
// );

//     assign out = src_a + src_b;
// endmodule


module adder3 #(
    parameter int WIDTH = 32,
    parameter int WADD = 16,
    localparam int NCYC = (WIDTH + WADD - 1) / WADD,
    localparam int WCYC = $clog2(NCYC)
) (
    input logic clk,
    input logic rst,
    input logic start,

    input adderOp_t op,
    input logic signed[WIDTH-1:0] src_a,
    input logic signed[WIDTH-1:0] src_b,

    output logic[WIDTH-1:0] out,
    output logic cond,
    output logic done
);
    // state registers
    logic[WCYC-1:0] cycle /*verilator public_flat*/;
    logic cout;
    logic busy;

    wire [WADD:0] adder_a, adder_b;
    wire [WADD+1:0] adder_out;

    assign done = (!busy && !start) || (cycle == WCYC'(NCYC-1));

    always_ff @(posedge clk) begin
        if (rst) begin
            cycle <= 0;
            busy  <= 0;
        end else begin
            busy <= !done;
            cout <= adder_out[WADD+1];
            if (cycle == WCYC'(NCYC-1)) cycle <= 0;
            else if (!done) cycle <= cycle + 1;
        end
    end
    
    wire is_sub = op != ADDER_ADD;
    wire cin = busy ? cout : is_sub;
    wire [WADD-1:0] bmask = {WADD{is_sub}};
    assign adder_a = {src_a[cycle*WADD +: WADD], 1'b1};
    assign adder_b = {src_b[cycle*WADD +: WADD] ^ bmask, cin};

    assign adder_out = adder_a + adder_b;

    logic [WIDTH-1:0] out_reg;
    always_comb begin
        for (int i = 0; i < NCYC; i++) begin
            out_reg[i*WADD +: WADD] = (cycle == WCYC'(i)) ? adder_out[WADD:1] : src_a[i*WADD +: WADD];
        end
    end

    always_comb begin
        unique case (op)
            ADDER_EQ: cond = out_reg == 0;
            ADDER_NE: cond = out_reg != 0;
            ADDER_LT: cond = adder_out[WADD+1] ^ adder_a[WADD] ^ adder_b[WADD];
            ADDER_GE: cond = adder_out[WADD+1] ^ adder_a[WADD] ^ adder_b[WADD] ^ 1'b1;
            ADDER_LTU: cond = ~adder_out[WADD+1];
            ADDER_GEU: cond = adder_out[WADD+1];
            default: cond = 'x;
        endcase
    end
    wire cond_out = (cycle == WCYC'(NCYC-1)) && (op != ADDER_ADD && op != ADDER_SUB);
    assign out = cond_out ? {(WIDTH-1)'(0), cond} : out_reg;
    // assign out = out_reg;
endmodule