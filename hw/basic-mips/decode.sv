module decode(
	input logic     clk, rst, stall_d,
	input word_t    pc_in, instr_in,
	input word_t    r1_val, r2_val,
	output word_t   pc_out, instr_out,
	output word_t   alu_1, alu_2, store_val
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
			alu_1 <= r1_val;
			case (ext_opcode(instr_in))
				OP_STORE: begin
					store_val	<= r2_val;
					alu_2 		<= 0; // FIXME
				end
			endcase
		end
endmodule
