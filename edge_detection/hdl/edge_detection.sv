/**
 * File              : edge_detection.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 12.04.2026
 * Last Modified Date: 12.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */


module edge_detection (
    input  clk,
    input  rst,
    input  signal,
    output rising_edge,
    output falling_edge
);

  logic current_value_q;
  logic previous_value_q;

  register #(
      .DATA_WIDTH(1)
  ) current_reg (
      .clk(clk),
      .cl(rst),
      .w(1),
      .din(signal),
      .dout(current_value_q)
  );

  register #(
      .DATA_WIDTH(1)
  ) previous_reg (
      .clk(clk),
      .cl(rst),
      .w(1),
      .din(current_value_q),
      .dout(previous_value_q)
  );

  //flanco de subida cuando current_value_q == 1 y previous_value_q ==0
  assign rising_edge  = current_value_q & ~(previous_value_q);
  //flanco de bajada cuando current_value_q == 0 y previous_value_q ==1
  assign falling_edge = ~(current_value_q) & previous_value_q;

endmodule
