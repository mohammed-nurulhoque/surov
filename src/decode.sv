module decode(
	input logic     clk, rst, stall_d,
	input word_t    pc_in, instr_in,
	input word_t    src_a_in, src_b_in,
	output word_t   pc_out, instr_out,
	output word_t   src_a_out, src_b_out
);
	
	assign rs1 = instr_in[19:15];
	assign rs2 = instr_in[24:20];
	
	always_ff@(posedge clk)
		if (rst) begin
			pc_out    <= 0;
			instr_out <= NOP;
		end else if (!stall_d) begin
			pc_out    <= pc_in;
			instr_out <=  instr_in;
			src_a_out <= src_a_in;
			src_b_out <= src_b_in;
		end
endmodule
