`timescale 1ns / 1ps
module testbench();
reg A;
wire [2:0] sel;
top dut(A,sel);
integer k = 0;
initial begin
A = 0;
for(k = 0; k < 24; k = k +1 )
#4 A = k;
#10 $finish;
end
endmodule
