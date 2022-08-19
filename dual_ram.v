module dual_ram (clk, wr_en, wr_addr, rd_addr, wr_data, rd_data);
	parameter n = 16;
	parameter w = 4;
	input clk,wr_en;
	input [w-1:0] rd_addr, wr_addr;
	input [7:0] wr_data;
	
	output [7:0] rd_data;
	
	reg [7:0] RAM [n-1:0];
	
	always@(posedge clk)
	begin
		if(wr_en)
		begin
			RAM[wr_addr] <= wr_data;
		end
		else
		begin
			RAM[wr_addr] <= RAM[wr_addr];
		end
	end
	
	assign rd_data = RAM[rd_addr];
	
	
endmodule
