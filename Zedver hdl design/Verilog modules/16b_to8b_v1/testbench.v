`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2019 13:13:49
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
reg [15:0] in = 0;
wire [7:0] out;
top dut(
    .in(in),
    .out(out));
integer k = 0;
initial begin
for(k = 0 ; k < 5000 ; k = k + 8)
#4 in = k;
#10 $finish;
end
endmodule
