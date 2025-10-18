module cntrs  (
    input logic clk,
    input logic rst,
    input logic[1:0] cycle,
    input logic[1:0] max_cycle,
    input logic start,
    input cntr_t addr,
    output word_t data
);
    word_t counters[0:1] /*verilator public*/;

    word_t adder;
    wire update_inst = cycle == 1 && start;
    logic[2:0] adder_b = (update_inst || !start) ? 3'h1 : (max_cycle + 1);
    assign adder = counters[update_inst] + word_t'(adder_b);
    always_ff @(posedge clk) begin
        if (rst)
            {counters[0], counters[1]} <= 64'h0;
        else if (cycle == 0 || !start)
            counters[0] <= adder;
        else if (cycle == 1)
            counters[1] <= adder;
    end

    assign data = counters[addr[1]];
endmodule