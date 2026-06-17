/**
 * File              : adder.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 03.04.2026
 * Last Modified Date: 03.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module adder #(
    parameter N = 4
) (
    input [N-1:0] a,
    input [N-1:0] b,
    input cin, //este parametro no seria necesario, pero facilita la implementacion del modulo adder_subtractor
    output [N-1:0] sum,
    output cout
);


  genvar i;
  logic [0:0] carry_values[N:0];
  //la linea comentada es por si quitamos el parametro cin
  //assign carry_values[0] = 0
  assign carry_values[0] = cin;
  generate
    for (i = 0; i < N; i++) begin
      full_adder fa_i (
          .a(a[i]),
          .b(b[i]),
          .cin(carry_values[i]),
          .sum(sum[i]),
          .cout(carry_values[i+1])
      );
    end
  endgenerate

  assign cout = carry_values[N];

endmodule : adder

