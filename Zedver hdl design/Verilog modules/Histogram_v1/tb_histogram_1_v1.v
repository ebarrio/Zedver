`timescale 1ns / 1ps

module testbench();

reg clk = 0;
reg rst = 1;        //-- Señal de reloj global
reg [7: 0] addr = 8'b0;    //-- Direccion = Bin
reg rw = 0;             //-- Modo lectura (1) o escritura/adquisición (0)
reg [15: 0] data_in = 16'b0;   //-- Dato lectura
wire [15: 0] data_out; //-- Dato escritura

histogram_v1 dut(
    .rst(rst),
    .clk(clk),
    .addr(addr),
    .rw(rw),
    .data_in(data_in),
    .data_out(data_out));
 
integer k = 0;
integer NPOS = 2 ** 8; // Numero bins
initial begin
//#20 //Leemos estado inicial memoria
//rw = 1;
//for (k = 0; k < NPOS ; k = k + 1) begin
//#4 clk = ~ clk;
//addr = NPOS;
//end
#20 //Escribimos adquisicion todo ceros, data in a 0 al inicio.
rw = 0;
for (k = 0; k < NPOS ; k = k + 1) begin
#4 clk = ~ clk;
addr = NPOS;
end
#20 //Leemos estado final memoria
rw = 1;
for (k = 0; k < NPOS ; k = k + 1) begin
#4 clk = ~ clk;
addr = NPOS;
end
#20 rst = ~ rst;
#4 rst = ~ rst; // Reiniciamos y volvemos a leer
rw = 1;
for (k = 0; k < NPOS ; k = k + 1) begin
#4 clk = ~ clk;
addr = NPOS;
end
#8 $finish;
end
endmodule
