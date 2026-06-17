/**
 * File              : fast_adder_4.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module fast_adder_4 (
    input [3:0] a,
    input [3:0] b,
    input carry_in,
    output [3:0] s,
    output c
);

  logic [3:0] carry_values;
  logic [3:0] P;
  logic [3:0] G;

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin
      full_adder_propagation f_i (
          .a(a[i]),
          .b(b[i]),
          .c(carry_values[i]),
          .s(s[i]),
          .p(P[i]),
          .g(G[i])
      );
    end
  endgenerate

  //C[i+1] = G[i] + P[i]C[i]
  assign carry_values[0] = carry_in;
  assign carry_values[1] = G[0] | (P[0] & carry_values[0]);
  assign carry_values[2] = G[1] | (G[0] & P[1]) | (P[0] & carry_values[0] & P[1]);
  assign carry_values[3] = G[2] |
                            (G[1] & P[2]) |
                            (G[0] & P[1] & P[2]) |
                            (P[0] & carry_values[0] & P[1] & P[2]);
  assign c = G[3] |
               (G[2] & P[3]) |
               (G[1] & P[2] & P[3]) |
               (G[0] & P[1] & P[2] & P[3]) |
               (P[0] & carry_values[0] & P[1] & P[2] & P[3]);

endmodule : fast_adder_4
