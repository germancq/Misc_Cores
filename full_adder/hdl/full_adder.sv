/**
 * File              : full_adder.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 03.04.2026
 * Last Modified Date: 03.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);

  logic ha1_sum;
  logic ha1_c;
  logic ha2_c;

  assign cout = ha1_c | ha2_c;

  half_adder ha1 (
      .a  (a),
      .b  (b),
      .sum(ha1_sum),
      .c  (ha1_c)
  );

  half_adder ha2 (
      .a  (ha1_sum),
      .b  (cin),
      .sum(sum),
      .c  (ha2_c)
  );

endmodule : full_adder
