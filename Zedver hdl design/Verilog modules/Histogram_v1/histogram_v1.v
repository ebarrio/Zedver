module histogram_v1 #(             //-- Parametros
         parameter AW = 8,   //-- Bits de las direcciones (Adress width)
                             // Los datos del ADC
         parameter DW = 16)   //-- Bits de los datos (Data witdh), máximo necesario equivale al numero de datos adquiscion

       (        //-- Puertos
         input clk,
         input rst,                      //-- Señal de reloj global
         input [AW-1: 0] addr,      //-- Direcciones
         input rw,                  //-- Modo lectura (1) o escritura (0)
         input [DW-1: 0] data_in,   //-- Dato lectura
         output [DW-1: 0] data_out); //-- Dato escritura
wire clk;
wire rst;
wire [AW-1: 0] addr;
wire rw;
wire [DW-1: 0] data_in;
reg [DW-1: 0] data_out = 16'b0; //-- Dato escritura
//-- Calcular el número de posiciones totales de memoria con los bits del bus de dirección
localparam NPOS = 2 ** AW;
integer j = 0;
//-- Memoria
reg [DW-1: 0] ram [0: NPOS-1];
// - Inicializacion RAM
  initial begin
    for(j = 0; j < NPOS ; j = j + 1)
        ram[j] = 0;
  end

//-- Lectura de la memoria
  always @(posedge clk) begin
    if (rw == 1)
        data_out <= ram[addr];
  end

  //-- Adquisción valor
  always @(posedge clk) begin
    if (rw == 0)
     ram[addr] <= ram[addr] + 16'b1; // Incrementamos la cuenta del bin
  end
  
  //-- Reset activo con bajo
  always @ (rst) begin
    if (~ rst) begin
        for (j = 0; j < NPOS; j = j + 1) begin
            ram[j] <= 16'b0;
        end
    end
  end
endmodule