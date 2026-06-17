/**
 * File              : mux.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 13.03.2026
 * Last Modified Date: 13.03.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module mux #(
    parameter N = 8
) (
    input [N-1:0] a,
    input [N-1:0] b,
    input sel,
    output [N-1:0] dout
);

  assign dout = (sel == 0) ? a : b;

endmodule : mux
