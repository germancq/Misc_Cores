/**
 * File              : register.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 03.04.2026
 * Last Modified Date: 03.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module register #(
    parameter DATA_WIDTH = 8
) (
    input clk,
    input cl,
    input w,
    input [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);

  always_ff @(posedge clk) begin
    if (cl) begin
      dout <= 0;
    end else if (w) begin
      dout <= din;
    end
  end

endmodule : register

