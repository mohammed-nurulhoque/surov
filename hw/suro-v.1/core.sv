module core (
    input logic clk,
    input logic rst,

    output word_t  mem_addr,
    output logic mem_rden,
    output logic mem_wren,
    output mem_addr_t mem_size,
    input  word_t memread_data,
    output word_t memwrite_data
);
    ctrl_t ctrl;
    logic done;
    opcode_t opcode;

    word_t rf[0:31]; // Register file
    regnum_t  regnum;
    word_t rfread_data;
    word_t rfwrite_data;
    logic rf_wren;


    datapath dp (
        .clk(clk),
        .rst(rst),
        .ctrl(ctrl),
        .done(done),
        .opcode(opcode),
        .regnum(regnum),
        .rfread_data(rfread_data),
        .rfwrite_data(rfwrite_data),
        .mem_addr(mem_addr),
        .mem_size(mem_size),
        .memread_data(memread_data),
        .memwrite_data(memwrite_data)
    );

    control cp (
        .clk(clk),
        .rst(rst),
        .opcode(),
        .done(done),
        .ctrl(ctrl),
        .rf_wren(rf_wren), // Write to RF if rfwrite_data is not zero
        .mem_rden(mem_rden),
        .mem_wren(mem_wren)
    );

    // Register file read/write
    always_ff @(posedge clk) begin
        if (rf_wren) begin
            rf[regnum] <= rfwrite_data;
        end
    end

    assign rfread_data = rf[regnum];
endmodule