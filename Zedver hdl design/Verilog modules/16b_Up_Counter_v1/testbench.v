`timescale 1ns / 1ps

module testbench();

reg clk = 0;
reg rst = 1;
wire [15:0] out;
up_counter dut(
    .rst(rst),
    .clk(clk),
    .out(out));
 
integer k = 0;
initial begin
#8
rst = 0;
for(k = 0; k < 5000 ; k = k + 1)
#4 clk = ~ clk;
#8 $finish;
end
endmodule
