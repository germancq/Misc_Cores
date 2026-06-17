/**
 * File              : uart_half_duplex.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module uart_half_duplex #(
    parameter CLK_HZ  = 100000000,
    parameter BAUDIOS = 1000000
) (
    input clk,
    input rst,
    inout bus_data,
    output [7:0] rx_data,
    input [7:0] tx_data,
    input tx_start,
    output tx_done,
    output rx_done,
    output tx_active,
    output rx_active,
    output rx_debug,
    output tx_debug,
    output [2:0] estado_tx,
    output [2:0] estado_rx

);

  assign rx_debug = rx;
  assign tx_debug = tx;

  logic rx, tx;
  logic half_trasmission;

  uart #(
      .CLK_HZ (CLK_HZ),
      .BAUDIOS(BAUDIOS)
  ) uart_ints (
      .clk(clk),
      .rst(rst),
      .rx(rx),
      .tx(tx),
      .tx_start(half_trasmission),
      .byte_tx(tx_data),
      .byte_rx(rx_data),
      .rx_active(rx_active),
      .tx_active(tx_active),
      .tx_done(tx_done),
      .rx_done(rx_done),
      .estado_rx(estado_rx),
      .estado_tx(estado_tx)
  );

  half_duplex hd (
      .tx(tx),
      .rx(rx),
      .tx_ocupado(tx_active),
      .rx_ocupado(rx_active),
      .iniciar(tx_start),
      .transmitir(half_trasmission),
      .linea(bus_data)
  );

endmodule
