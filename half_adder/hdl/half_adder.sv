/**
 * File              : half_adder.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 03.04.2026
 * Last Modified Date: 03.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module half_adder (
    input  a,
    input  b,
    output sum,
    output c
);

  assign sum = a ^ b;
  assign c   = a & b;

endmodule : half_adder
