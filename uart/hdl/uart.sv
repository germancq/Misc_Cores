/**
 * File              : uart.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 06.04.2026
 * Last Modified Date: 06.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module uart #(
    parameter BAUDIOS = 9600,
    parameter CLK_HZ  = 100000000
) (
    input clk,
    input rst,
    input rx,
    output tx,
    input tx_start,
    input [7:0] tx_byte,
    output [7:0] rx_byte,
    output rx_active,
    output tx_active,
    output tx_done,
    output rx_done
);

  uart_rx #(
      .BAUDIOS(BAUDIOS),
      .CLK_HZ (CLK_HZ)
  ) recepcion (
      .clk (clk),
      .rst (rst),
      .rx  (rx),
      .dout(rx_byte),
      .busy(rx_active),
      .done(rx_done)
  );

  uart_tx #(
      .BAUDIOS(BAUDIOS),
      .CLK_HZ (CLK_HZ)
  ) transmision (
      .clk(clk),
      .rst(rst),
      .start(tx_start),
      .din(tx_byte),
      .tx(tx),
      .busy(tx_active),
      .done(tx_done)
  );

endmodule : uart
