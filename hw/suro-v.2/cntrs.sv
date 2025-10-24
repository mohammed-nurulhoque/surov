module cntrs  (
    input logic clk,
    input logic rst,
    input logic[1:0] cycle,
    input logic start,
    input cntr_t addr,
    output word_t data
);
    word_t counters[0:1] /*verilator public*/;
    always_ff @(posedge clk) begin
        if (rst)
            {counters[0], counters[1]} <= 64'h0;
        else begin
            counters[0] <= counters[0] + 1;
            if (cycle == 0 && start)
                counters[1] <= counters[1] + 1;
        end
    end

    assign data = counters[addr[1]];
endmodule