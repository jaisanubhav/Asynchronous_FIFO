module async_fifo_tb; 

reg [7:0] wr_data;
reg wclk,rclk,winc,rinc,wrst_n,rrst_n;
wire wfull,rempty;

wire [7:0] rd_data;

async_fifo dut (rclk, wclk, wrst_n, rrst_n, rinc, winc, rd_data, wr_data, wfull, rempty);


initial
	begin
		wclk = 0;
		rclk = 0;
		wrst_n = 1;
		rrst_n = 1;
		rinc = 1;
		winc	= 1;
		#5 wrst_n = 0;
		#5 rrst_n = 0;
		#5 wrst_n = 1;
		#5 rrst_n = 1;
		
		#20 wr_data = 1;
		 
		#20 wr_data = 2;
		#20 wr_data = 3;
		#20 wr_data = 4;
		#20 wr_data = 5;
		
		#100000 rinc = 0;
		
		
	end
	

always #10 wclk = ~wclk;
always #100 rclk = ~rclk;
	

endmodule
