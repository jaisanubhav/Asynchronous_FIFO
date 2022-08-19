module wptr_full (wclk, winc, wrst_n, wq2_rptr, waddr, wptr, wfull);
	parameter n = 4;
	input wclk, winc, wrst_n;
	input [n:0] wq2_rptr;
	output [n-1:0] waddr;
	output reg [n:0] wptr;
	output reg wfull;
	
	reg [n:0] bin;
	wire [n:0] bnext, gnext;
	
	wire wfull_w;

	assign waddr = bin[n-1:0];
	
	assign bnext = bin + (winc & ~wfull);
	
	assign gnext = (bnext >> 1) ^ bnext;
	
	assign wfull_w = (wrst_n==1) ? (gnext == {~wq2_rptr[n:n-1], wq2_rptr[n-2:0]}) : 1'b0;
	
	always@(posedge wclk or negedge wrst_n)
	begin
		if(~wrst_n)
		begin
			wptr <= 0;
			bin <= 0;
			wfull <= 0;
		end
		else
		begin
			wptr <= gnext ;
			bin <= bnext;
			wfull <= wfull_w;
		end
	end
	
endmodule

