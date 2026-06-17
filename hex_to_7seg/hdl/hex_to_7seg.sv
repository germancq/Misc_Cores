/**
 * File              : hex_to_7seg.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 03.04.2026
 * Last Modified Date: 03.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module hex_to_7seg #(
    parameter COMMON_ANODE = 1
) (
    input  [3:0] data_in,
    output [6:0] data_out
);

  logic [6:0] lut_data[15:0];
  //gfedcba - common anode//
  assign lut_data[0] = 7'b1000000;
  assign lut_data[1] = 7'b1111001;
  assign lut_data[2] = 7'b0100100;
  assign lut_data[3] = 7'b0110000;
  assign lut_data[4] = 7'b0011001;
  assign lut_data[5] = 7'b0010010;
  assign lut_data[6] = 7'b0000010;
  assign lut_data[7] = 7'b1111000;
  assign lut_data[8] = 7'b0000000;
  assign lut_data[9] = 7'b0010000;
  assign lut_data[10] = 7'b0001000;
  assign lut_data[11] = 7'b0000011;
  assign lut_data[12] = 7'b1000110;
  assign lut_data[13] = 7'b0100001;
  assign lut_data[14] = 7'b0000110;
  assign lut_data[15] = 7'b0001110;

  assign data_out = COMMON_ANODE == 1 ? lut_data[data_in] : ~lut_data[data_in];

endmodule
