module surov (
    input logic clk,
    input logic rst,

    output word_t  mem_addr,
    output logic mem_rden,
    output logic mem_wren,
    output mem_addr_t mem_size,
    input  word_t memread_data,
    output word_t memwrite_data,

    output trap
);
    ctrl_t ctrl;
    logic done;
    word_t inst;

    logic[1:0] cycle /*verilator public*/;
    logic[1:0] max_cycle;

    regnum_t  regnum;
    word_t rfread_data;
    word_t rfwrite_data;
    logic rf_wren;

    cntr_t cntr_addr;
    word_t cntr_data;

    word_t mem_latch;
    always_ff @( posedge clk ) begin
        mem_latch <= memread_data;
    end


    rf #(.WORD_SIZE(32), .REG_COUNT(`REG_COUNT)) r  (
        .clk(clk),
        .we(rf_wren),
        .addr(regnum),
        .wdata(rfwrite_data),
        .rdata(rfread_data)
    );

    datapath dp (
        .clk(clk),
        .rst(rst),
        .ctrl(ctrl),
        .done(done),
        .inst(inst),
        .regnum(regnum),
        .rfread_data(rfread_data),
        .rfwrite_data(rfwrite_data),
        .cntr_addr(cntr_addr),
        .cntr_data(cntr_data),
        .mem_addr(mem_addr),
        .mem_size(mem_size),
        .memread_data(mem_latch),
        .memwrite_data(memwrite_data)
    );

    control cp (
        .clk(clk),
        .rst(rst),
        .inst(inst),
        .done(done),
        .control(ctrl),
        .rf_wren(rf_wren),
        .mem_rden(mem_rden),
        .mem_wren(mem_wren),
        .cycle(cycle),
        .max_cycle(max_cycle),
        .trap(trap)
    );

    cntrs cn (
        .clk(clk),
        .rst(rst),
        .cycle(cycle),
        .max_cycle(max_cycle),
        .start(ctrl.start),
        .addr(cntr_addr),
        .data(cntr_data)
    );
endmodule