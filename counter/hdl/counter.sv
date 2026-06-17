/**
 * File              : counter.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 03.04.2026
 * Last Modified Date: 03.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module counter #(
    parameter DATA_WIDTH = 8
) (
    input clk,
    input rst,
    input up,
    input down,
    input [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);

  always_ff @(posedge clk) begin
    if (rst) begin
      dout <= din;
    end else if (up) begin
      dout <= dout + 1;
    end else if (down) begin
      dout <= dout - 1;
    end

  end

endmodule : counter

