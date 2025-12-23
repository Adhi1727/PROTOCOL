module apb_master(
input pclk,
input preset,
input trans,
input re_wr,
input pready,
input [7:0] wr_paddr,
input [7:0] wr_data,
input [7:0] re_paddr,
input [7:0] pdata,
output reg psel,
output reg pena,
output reg pwrite,
output reg [7:0] paddr,
output reg [7:0] pwr_data,
output reg [7:0] re_data_out
);

reg [1:0] state,next_state;
parameter IDLE = 2'b00;
parameter SETUP = 2'b01;
parameter ACCESS = 2'b10;

always @(*) begin
	case(state)
		IDLE:
			next_state = trans?SETUP:IDLE;
		SETUP:
			next_state = ACCESS;
		ACCESS:
			next_state = (pready==0)?ACCESS:(trans?SETUP:IDLE);
	endcase
end

always @(posedge pclk or negedge preset) begin
	if(!preset)
		state <= IDLE;
	else
		state <= next_state;
end

always @(*) begin
	psel = (state != IDLE);
	pena = (state==ACCESS);

	pwrite = 1'b0;
	paddr = 8'b0;
	pwr_data = 8'b0;
	re_data_out = 8'b0;

	if(state == SETUP || state == ACCESS) begin
		pwrite = re_wr;
		pwr_data = re_wr?wr_data:8'b0;
		paddr = re_wr?wr_paddr:re_paddr;
		re_data_out = re_wr?8'b0:pdata;
	end
end
endmodule
