module async_fifo (rclk, wclk, wrst_n, rrst_n, rinc, winc, rd_data, wr_data, wfull, rempty);
	parameter n = 16;
	parameter w = 4;
	input rclk, wclk, rinc, winc, wrst_n, rrst_n;
	input [7:0] wr_data;
	output [7:0] rd_data;
	
	output wfull, rempty;
	
	wire wr_en, wfull, rempty;
	wire [w-1:0] waddr, raddr; 
	
	wire [w:0] rptr, wptr, rq2_wptr, wq2_rptr;
	
	assign wr_en = winc && ~wfull;
	
	dual_ram dr1 (wclk, wr_en, waddr, raddr, wr_data, rd_data);
	
	synchronizer sw (wclk, wrst_n, rptr, wq2_rptr);
	synchronizer sr (rclk, rrst_n, wptr , rq2_wptr);
	
	wptr_full wf1 (wclk, winc, wrst_n, wq2_rptr, waddr, wptr, wfull);
	
	rptr_empty re1 (rclk, rinc, rrst_n, rq2_wptr, raddr, rptr, rempty);

endmodule
