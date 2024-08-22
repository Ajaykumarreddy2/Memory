`include "mem.v"
module tb;
	parameter width=8;
	parameter depth=16;
	parameter addr=$clog2(depth);


	reg clk,rst,valid,rw_en;
	reg [width-1:0]w_data;
	reg [addr-1:0]addr_i;

	wire ready;
	wire [width-1:0]r_data;
	reg [width-1:0] memory[depth-1:0];
	integer i;
	reg [8000:0]testcase;
mem m(.*);
always #5 clk=~clk;
initial begin
 $value$plusargs("testcase=%s",testcase);
clk=0;rst=1;
#30
rst=0;
#10
  	case(testcase)
		"fd_write_fd_read":begin fd_write(0,depth); fd_read(0,depth); end
		"fd_write_bd_read":begin fd_write(0,depth); bd_read(); end
		"bd_write_fd_read":begin bd_write(); 	   fd_read(0,depth); end
		"bd_write_bd_read":begin bd_write(); 	   bd_read(); end
	endcase

	end	
task fd_write(input reg [addr-1:0] start,input reg [addr:0] end_loc);
begin
	for(i=start;i<end_loc;i=i+1) begin
	  @(posedge clk) 
		valid=1;
		rw_en=1;
		wait (ready==1);
		addr_i=i;
		w_data=$random;
	end
end
endtask
task fd_read(input reg [addr-1:0] start,input reg [addr:0]end_loc);
begin
	for(i=start;i<end_loc;i=i+1)begin
	  @(posedge clk)
	    valid=1;
		rw_en=0;
		wait (ready==1);
		addr_i=i;
	end
end
endtask

task bd_write();
begin
	$readmemh("img.hexa",m.memory);// instance.arrayname
	end
endtask

task bd_read();
begin
	$writememh("im.hexa",m.memory);
	end
endtask

  initial #1000 $finish;
endmodule
