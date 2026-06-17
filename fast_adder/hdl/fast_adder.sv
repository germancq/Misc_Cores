/**
 * File              : fast_adder.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module fast_adder #(
    parameter N = 32
) (
    input [N-1:0] a,
    input [N-1:0] b,
    output [N-1:0] s,
    output c
);


  logic [N>>2:0] carry_values;
  assign carry_values[0] = 0;
  assign c = carry_values[N>>2];

  genvar i;
  generate
    for (i = 0; i < (N >> 2); i = i + 1) begin
      fast_adder_4 f_i (
          .a(a[(4*i)+3:4*i]),
          .b(b[(4*i)+3:4*i]),
          .carry_in(carry_values[i]),
          .s(s[(4*i)+3:4*i]),
          .c(carry_values[i+1])
      );
    end
  endgenerate


endmodule : fast_adder

