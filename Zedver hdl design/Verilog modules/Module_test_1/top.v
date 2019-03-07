`timescale 1ns / 1ps
module top(
    input [23:0] A,
    output [2:0] sel
    );
    reg [2:0] sel = 0;
    always @(A)
        sel <= sel + 1;            
endmodule
