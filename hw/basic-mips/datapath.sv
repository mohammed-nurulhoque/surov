`include "defs.sv"
`include "fetch.sv"
`include "decode.sv"
`include "execute.sv"

module datapath(
	input logic clk, rst, kill_d, kill_e, stall_f, stall_d, stall_e, branch_taken, wr_en
);
	word_t pcFromF, pcFromD, pcFromE, pcFromM;
	word_t instrFromF, instrFromD, instrFromE, instrFromM;
	word_t src_aFromD, src_bFromD;
	word_t dataFromE;
	word_t branch_target, wr_data;

	Fetch F(.clk, .rst, .stall_f, .branch_taken, .branch_target,
	        .pc_out(pcFromF), .instr_out(instrFromF));
	
	// wires routing between register file and decode
	word_t src_a, src_b;
	decode D(.clk, .rst(rst || kill_d), .stall_d, 
	         .pc_in(pcFromF), .instr_in(instrFromF),
	         .src_a_in(src_a), .src_b_in(src_b),
	         .pc_out(pcFromD), .instr_out(instrFromD),
	         .src_a_out(src_aFromD), .src_b_out(src_bFromD));
	regfile RF(.clk, .rs1(ext_rs1(instrFromF)), .rs2(ext_rs2(instrFromF)), .rd(ext_rd(instrFromM)), .wr_en, .wr_data,
	           .data_1(src_a), .data_2(src_b));

	Execute E(.clk, .rst(rst || kill_e), .stall_e,
	          .pc_in(pcFromD), .instr_in(instrFromD), .src_a_in(src_aFromD), .src_b_in(src_bFromD),
	          .pc_out(pcFromE), .instr_out(instrFromE), .data(dataFromE));
endmodule


module regfile(
		input logic clk,
		input regnum_t rs1,
		input regnum_t rs2,
		input regnum_t rd,
		input logic wr_en,
		input word_t wr_data,
		output word_t data_1,
		output word_t data_2
);
	word_t rf[31:0];
	always_ff@(posedge clk) begin
		data_1 = rf[rs1];
		data_2 = rf[rs2];
		if (wr_en && rd != 0)
			rf[rd] <= wr_data;
	end
endmodule
