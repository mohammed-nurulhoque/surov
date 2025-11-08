module cntrs  (
    input logic clk,
    input logic rst,
    input logic next_instr,
    input cntr_t addr,
    output word_t data
);
    // counter 0: cycle, 1: instret
    word_t counters[0:1] /*verilator public*/;
    always_ff @(posedge clk) begin
        if (rst)
            {counters[0], counters[1]} <= 64'h0;
        else begin
            counters[0] <= counters[0] + 1;
            if (next_instr)
                counters[1] <= counters[1] + 1;
        end
    end

    // time returns cycle
    assign data = counters[addr[1]];
endmodule