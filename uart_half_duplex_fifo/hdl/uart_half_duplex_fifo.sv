/**
 * File              : uart_half_duplex_fifo.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */
module uart_half_duplex_fifo #(
    parameter CLK_HZ = 100000000,
    parameter BAUDIOS = 1000000,
    parameter FIFO_DEPTH = 16
) (
    input clk,
    input rst,
    inout bus_data,
    output [7:0] data_rx,
    input [7:0] byte_tx,
    input tx_start,
    output rx_empty,
    output tx_empty,
    output rx_full,
    output tx_full,
    output [$clog2(FIFO_DEPTH):0] rx_bytes_available,
    output rx_active,
    output tx_active,
    input read_byte,
    output debug_pop_tx,
    output debug_start_tx,
    output [7:0] debug_data_tx,
    output [7:0] debug_byte_rx,
    output [2:0] estado_tx,
    output [2:0] estado_rx
);

  assign debug_start_tx = start_tx;
  assign debug_pop_tx   = pop_tx;
  assign debug_data_tx  = data_tx;
  assign debug_byte_rx  = byte_rx;
  logic start_tx;
  logic [7:0] byte_rx;
  logic [7:0] data_tx;
  logic rx_done;
  uart_half_duplex #(
      .CLK_HZ (CLK_HZ),
      .BAUDIOS(BAUDIOS)
  ) uart_ints (
      .clk(clk),
      .rst(rst),
      .bus_data(bus_data),
      .tx_start(start_tx),
      .tx_data(data_tx),
      .rx_data(byte_rx),
      .tx_active(tx_active),
      .rx_active(rx_active),
      .estado_rx(estado_rx),
      .estado_tx(estado_tx),
      .tx_done(),
      .rx_done(rx_done)
  );


  stack #(
      .FIFO_LIFO(0),
      .DEPTH(FIFO_DEPTH),
      .WIDTH(8)
  ) rx_fifo (
      .clk(clk),
      .rst(rst),
      .data_i(byte_rx),
      .data_o(data_rx),
      .push(rx_done),
      .pop(read_byte),
      .empty(rx_empty),
      .full(rx_full),
      .sp_index(rx_bytes_available)
  );

  logic pop_tx;
  //assign pop_tx = (tx_active == 1 || rx_active == 1) ? 0 : (tx_empty == 1) ? 0 : 1;
  stack #(
      .FIFO_LIFO(0),
      .DEPTH(FIFO_DEPTH),
      .WIDTH(8)
  ) tx_fifo (
      .clk(clk),
      .rst(rst),
      .data_i(byte_tx),
      .data_o(data_tx),
      .push(tx_start),
      .pop(pop_tx),
      .empty(tx_empty),
      .full(tx_full)
  );

  logic prev_tx_active, prev_rx_active, prev_tx_start, prev_pop_tx;
  always_ff @(posedge clk) begin
    prev_tx_active <= tx_active;
    prev_rx_active <= rx_active;
    prev_tx_start <= tx_start;
    prev_pop_tx <= pop_tx;
    start_tx <= prev_pop_tx;
    if (rst) begin
      pop_tx <= 0;
      prev_tx_active <= 0;
      prev_rx_active <= 0;
      prev_tx_start <= 0;
    end
    if (pop_tx == 0 && start_tx == 0 && prev_pop_tx == 0) begin
      if((prev_tx_active != tx_active) || (prev_rx_active != rx_active) || (prev_tx_start != tx_start)) begin
        pop_tx <= (tx_active == 1 || rx_active == 1) ? 0 : (tx_empty == 1) ? 0 : 1;
      end
    end else begin
      pop_tx <= 0;
    end
  end



endmodule


