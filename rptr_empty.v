module rptr_empty (rclk, rinc, rrst_n, rq2_wptr, raddr, rptr, rempty);
	parameter n = 4;
	input rclk, rinc, rrst_n;
	input [n:0] rq2_wptr;
	output [n-1:0] raddr;
	output reg [n:0] rptr;
	output reg rempty;
	
	reg [n:0] bin;
	wire [n:0] bnext, gnext;
	
	wire rempty_w;
	
	assign raddr = bin[n-1:0];
	
	assign bnext = bin + (rinc & (~rempty));
	
	assign gnext = (bnext >> 1) ^ bnext;
	
	assign rempty_w = gnext == rq2_wptr;
	
	always@(posedge rclk or negedge rrst_n)
	begin
		if(~rrst_n)
		begin
			rptr <= 0;
			bin <= 0;
			rempty <= 1;
		end
		else
		begin
			rptr <= gnext;
			bin <= bnext;
			rempty <= rempty_w;
		end
	end
	
endmodule

