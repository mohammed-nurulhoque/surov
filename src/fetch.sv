module Fetch(
	input logic   clk,
	input logic   rst,
	input logic   stall_f,
	input logic   branch_taken,
	input word_t  branch_target,
	output word_t pc_out,
	output word_t instr_out
);
	word_t imem[256:0];
	initial begin
		$readmemh("imem.hex", imem);
	end

	word_t pc;
	always_comb
		if (rst) begin
			pc = 0;
		end else if (!stall_f) begin
			if (branch_taken)
				pc = branch_target;
			else
				pc = pc_out+4;
		end

	always_ff@(posedge clk) begin
		instr_out <= imem[pc >> 2];
		pc_out <= pc;
	end
endmodule
