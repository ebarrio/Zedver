`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2019 20:18:26
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
