module apb_top(
input pclk,
input preset,
input re_wr,
input trans,
input [7:0] wr_paddr,
input [7:0] wr_data,
input [7:0] re_paddr,
output pready,
output [7:0] pdata
);

wire psel,pena,pwrite;
wire [7:0] paddr,pwr_data,re_data_out;

apb_master uut(
	.pclk(pclk),
	.preset(preset),
	.trans(trans),
	.re_wr(re_wr),
	.pready(pready),
	.wr_paddr(wr_paddr),
	.wr_data(wr_data),
	.re_paddr(re_paddr),
	.pdata(pdata),
	.psel(psel),
	.pena(pena),
	.pwrite(pwrite),
	.paddr(paddr),
	.pwr_data(pwr_data),
	.re_data_out(re_data_out)
);

apb_slave uut1(
	.pclk(pclk),
	.preset(preset),
	.pwrite(pwrite),
	.psel(psel),
	.pena(pena),
	.paddr(paddr),
	.pwr_data(pwr_data),
	.pdata(pdata),
	.pready(pready)
);
endmodule
