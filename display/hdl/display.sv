/**
 * File              : display.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 04.04.2026
 * Last Modified Date: 04.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module display #(
    parameter CLK_HZ = 100000,
    parameter FREC_DISPLAY = 500,
    parameter N = 32,
    parameter COMMON_ANODE = 1
) (
    input clk,
    input rst,
    input [N-1:0] din,
    output [(N>>2)-1:0] an, //32 bits, cada 4 bits representan un digito por tanto se necesitan N/4 anodos/catodos
    output [6:0] seg
);

  //necesitamos dividir la señal de reloj a un periodo de 2ms o 500Hz
  logic [31:0] counter_dout;
  logic [$clog2(N>>2)-1:0] an_counter;
  localparam DIV = $clog2(CLK_HZ / FREC_DISPLAY);  //$clog2(CLK_HZ) - $clog(500)
  counter #(
      .DATA_WIDTH(32)
  ) div_clk_module (
      .clk (clk),
      .rst (rst),
      .up  (1'b1),
      .down(1'b0),
      .din (0),
      .dout(counter_dout)
  );
  //para un contador de N/4 an necesitamos un tamaño de log2(N/4)
  assign an_counter = counter_dout[($clog2(N>>2))+DIV:DIV];


  //codificacion one-hot activo en bajo
  assign an = COMMON_ANODE == 1 ? ~(1'b1 << an_counter) : (1'b1 << an_counter);


  //dividimos el din en datos de 4bits por cada digito
  logic [3:0] din_i[(N>>2)-1:0];
  genvar i;
  generate
    for (i = 0; i < (N >> 2); i = i + 1) begin
      assign din_i[i] = din[(i<<2)+3:(i<<2)];
    end
  endgenerate


  //convertimos el dato de hex a 7seg
  hex_to_7seg #(
      .COMMON_ANODE(COMMON_ANODE)
  ) conversor (
      .data_in (din_i[an_counter]),
      .data_out(seg)
  );

endmodule : display
