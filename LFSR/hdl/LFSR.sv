/**
 * File              : LFSR.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 19.06.2026
 * Last Modified Date: 19.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module LFSR #(
    parameter DATA_WIDTH = 6,
    parameter LSB = 1
) (
    input clk,
    input rst,
    input shift,
    input [DATA_WIDTH:0] feedback_coeff,
    input [DATA_WIDTH-1:0] initial_state,
    output [DATA_WIDTH-1:0] state
);

  logic [DATA_WIDTH-1:0] state_reg;
  logic bit_xored;
  assign state = state_reg;

  assign bit_xored = LSB==1 ? ^(state_reg & feedback_coeff[DATA_WIDTH:1]) : ^(state_reg & feedback_coeff[DATA_WIDTH-1:0]);

  always_ff @(posedge clk) begin
    if (rst == 1) begin
      state_reg <= initial_state;
    end else if (shift == 1) begin
      if (LSB == 1) begin
        //this is the one used in twofish
        state_reg <= {state_reg[DATA_WIDTH-2:0], bit_xored};
      end else begin
        //mod realized for katan
        state_reg <= {bit_xored, state_reg[DATA_WIDTH-1:1]};
      end
    end
  end

endmodule : LFSR
