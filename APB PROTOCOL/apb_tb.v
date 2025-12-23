module apb_tb;
reg pclk;
reg preset;
reg trans;
reg re_wr;
reg [7:0] wr_paddr;
reg [7:0] re_paddr;
reg [7:0] wr_data;
wire pready;
wire [7:0] pdata;

apb_top uut(
	.pclk(pclk),
	.preset(preset),
	.re_wr(re_wr),
	.trans(trans),
	.wr_paddr(wr_paddr),
	.wr_data(wr_data),
	.re_paddr(re_paddr),
	.pready(pready),
	.pdata(pdata)
);

always #5 pclk = ~pclk;

initial begin
	$dumpfile("apb_pro.vcd");
	$dumpvars(0);
	pclk = 0;
	preset = 0;
	re_wr = 0;
	trans = 0;
	wr_paddr = 8'd0;
	re_paddr = 8'd0;
	wr_data = 8'd0;
	#10;

	preset = 1;

	#10;
	trans = 1;
	re_wr = 1;
	#5;
	wr_paddr = 8'h45;
	wr_data = 8'h67;
	#30;

	trans = 0;
	#30;

	trans = 1;
	re_wr = 0;
	re_paddr = 8'h45;
	#20;

	trans = 0;
	#30;
	$finish;
end
endmodule
