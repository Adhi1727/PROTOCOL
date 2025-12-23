module apb_slave(
input pclk,
input preset,
input pwrite,
input psel,
input pena,
input [7:0] paddr,
input [7:0] pwr_data,
output reg [7:0] pdata,
output reg pready
);

reg [7:0]mem[255:0];

always @(posedge pclk or negedge preset) begin
	if(!preset) begin
		pready <= 1'b0;
		pdata <= 8'b0;
	end
	else begin
		if(psel && pena) begin
			pready <= 1'b1;
			if(pwrite)
				mem[paddr] <= pwr_data;
			else
				pdata <= mem[paddr];
		end
		else
			pready <= 1'b0;
	end
end
endmodule
