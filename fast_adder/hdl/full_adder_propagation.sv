/**
 * File              : full_adder_propagation.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */
module full_adder_propagation (
    input  a,
    input  b,
    input  c,
    output p,
    output g,
    output s
);

  logic c_0;
  logic c_1;
  logic s_0;

  half_adder h0 (
      .a(a),
      .b(b),
      .carry(c_0),
      .s(s_0)
  );

  half_adder h1 (
      .a(s_0),
      .b(c),
      .carry(c_1),
      .s(s)
  );


  assign p = a ^ b;
  assign g = a & b;

endmodule : full_adder_propagation

