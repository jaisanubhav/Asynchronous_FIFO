module synchronizer (clk, rst, in, out);
	parameter n = 5;
	input clk, rst;
	input [n-1:0] in;
	output reg [n-1:0] out;
	
	reg [n-1:0] temp_ff;
	
	always@(posedge clk or negedge rst)
	begin
		if(~rst)
		begin
			temp_ff <= 0;
			out <= 0;
		end
		else
		begin
			temp_ff <= in;
			out <= temp_ff;
		end
	end
	
endmodule
