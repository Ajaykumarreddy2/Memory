module mem( clk,rst,addr_i,r_data,w_data,valid,ready,rw_en);
	parameter width=8;
	parameter depth=16;
	parameter addr=$clog2(depth);


	input clk,rst,valid,rw_en;
	input [width-1:0]w_data;
	input [addr-1:0]addr_i;

	output reg ready;
	output reg [width-1:0]r_data;
	reg [width-1:0] memory[depth-1:0];
	integer i;
always@(posedge clk)begin
	if(rst)begin
		ready=0;
		r_data=0;
		for(i=0;i<depth;i=i+1)
			memory[i]=0;
	end
	else begin
		if(valid)begin
		  	ready=1;
				if(rw_en) begin
					memory[addr_i]=w_data;end
				else begin
					r_data=memory[addr_i];end
			end
		else begin
			ready=0;end
	end
	end
	endmodule
		
	
