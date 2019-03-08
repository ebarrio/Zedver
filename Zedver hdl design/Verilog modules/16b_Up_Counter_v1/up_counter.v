`timescale 1ns / 1ps

module up_counter(
    input clk,
    input rst,
    output [15:0] out
    );
    
reg [15:0] cnt = 0;
    
always @(posedge clk) begin
if(rst)
    cnt <= 16'b0;
else
    cnt <= cnt + 1;
end
assign out = cnt;
endmodule
