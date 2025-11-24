module surov
#(
    parameter REG_COUNT = 32,
    parameter ENABLE_ZBA = 1,
    parameter ENABLE_FORWARD = 0,
    localparam WREGNUM= $clog2(REG_COUNT)
)
(
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
    logic branch_taken;
    logic forward;

    opcode_t opcode;
    opcode_t next_opcode;

    logic[1:0] stage /*verilator public*/;

    logic[WREGNUM-1 : 0]  regnum;
    word_t rfread_data;
    word_t rfwrite_data;
    logic rf_wren;

    cntr_t cntr_addr;
    word_t cntr_data;

    word_t mem_latch;
    always_ff @( posedge clk ) begin
        mem_latch <= memread_data;
    end


    rf #(.XLEN(32), .REG_COUNT(REG_COUNT)) r  (
        .clk(clk),
        .we(rf_wren),
        .addr(regnum),
        .wdata(rfwrite_data),
        .rdata(rfread_data)
    );

    datapath #(.REG_COUNT(REG_COUNT), .ENABLE_ZBA(ENABLE_ZBA), .ENABLE_FORWARD(ENABLE_FORWARD)) dp (
        .clk(clk),
        .rst(rst),
        .ctrl(ctrl),
        .done(done),
        .branch_taken(branch_taken),
        .forward(forward),
        .opcode(opcode),
        .next_opcode(next_opcode),
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
        .opcode(opcode),
        .next_opcode(next_opcode),
        .done(done),
        .branch_taken(branch_taken),
        .forward(forward),
        .ctrl(ctrl),
        .rf_wren(rf_wren),
        .mem_rden(mem_rden),
        .mem_wren(mem_wren),
        .stage(stage),
        .trap(trap)
    );

    cntrs cn (
        .clk(clk),
        .rst(rst),
        .next_instr(ctrl.set_ir),
        .addr(cntr_addr),
        .data(cntr_data)
    );
endmodule
