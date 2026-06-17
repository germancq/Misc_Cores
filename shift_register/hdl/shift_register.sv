/**
 * File              : shift_register.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 03.04.2026
 * Last Modified Date: 03.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module shift_register #(
    parameter DATA_WIDTH = 8
) (
    input clk,
    input cl,
    input w,
    input shift_r,
    input shift_l,
    input i_bit,
    input [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout,
    output logic o_bit
);

  always_ff @(posedge clk) begin
    if (cl) begin
      dout <= 0;
    end else if (w) begin
      dout <= din;
    end else if (shift_r) begin
      o_bit <= dout[0];
      dout  <= {i_bit, dout[DATA_WIDTH-1:1]};
    end else if (shift_l) begin
      o_bit <= dout[DATA_WIDTH-1];
      dout  <= {dout[DATA_WIDTH-2:0], i_bit};
    end

  end

endmodule : shift_register

