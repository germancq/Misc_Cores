/**
 * File              : top.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 09.04.2026
 * Last Modified Date: 09.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module top (
    input  [3:0] din,
    output [6:0] seg,
    output [3:0] an
);

  assign an = 0;

  hex_to_7seg dut (
      .data_in (din),
      .data_out(seg)
  );

endmodule
