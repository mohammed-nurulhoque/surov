module testBench ();
logic clk, rst;
logic[7:0] mem[2:0];
logic[7:0] b;
initial begin
clk = 0;
rst = 1;
$readmemh("imem", mem);
#5 clk = 1;
#5 clk = 0;
rst = 0;
forever begin
  #5 clk = ~clk;
  b = mem[clk];
end
end
top DUT( .clk, .rst);
endmodule
