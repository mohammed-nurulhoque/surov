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

    input ALUOp_t op,
    input logic signed[WIDTH-1:0] src_a,
    input logic signed[WIDTH-1:0] src_b,

    output logic[WIDTH-1:0] out,
    output logic done
);
    // state registers
    logic[WCYC-1:0] cycle /*verilator public_flat*/;
    logic cout;
    logic busy;

    wire [WADD:0] adder_a, adder_b;
    wire [WADD+1:0] adder_out;

    wire is_sub = op != ALU_ADD;
    wire is_signed_sub = (op == ALU_LT | op == ALU_GE);
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
    
    wire cin = busy ? cout : is_sub;
    wire [WADD-1:0] bmask = {WADD{is_sub}};
    assign adder_a = {src_a[cycle*WADD +: WADD], 1'b1};
    assign adder_b = {src_b[cycle*WADD +: WADD] ^ bmask, cin};

    assign adder_out = adder_a + adder_b;

    always_comb begin
        // Create a mask for the segment we want to modify
        logic [WIDTH-1:0] mask;
        logic [WIDTH-1:0] modified_segment;
        for (int i = 0; i < NCYC; i++) begin
            out[i*WADD +: WADD] = (cycle == WCYC'(i)) ? adder_out[WADD:1] : src_a[i*WADD +: WADD];
        end
    end
endmodule