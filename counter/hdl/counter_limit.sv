/**
 * File              : counter_limit.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module counter_limit #(
    parameter DATA_WIDTH = 8
) (
    input clk,
    input rst,
    input up,
    input down,
    input [DATA_WIDTH-1 : 0] din,
    output logic [DATA_WIDTH -1 : 0] dout
);



  always_ff @(posedge clk) begin
    if (rst == 1) begin
      dout <= din;
    end else if (up == 1) begin
      if (dout == {DATA_WIDTH{1'b1}}) begin
        dout <= dout;
      end else begin
        dout <= dout + 1;
      end
    end else if (down == 1) begin
      if (dout == 0) begin
        dout <= dout;
      end else begin
        dout <= dout - 1;
      end
    end
  end

endmodule : counter_limit


