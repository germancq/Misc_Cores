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


module mux_4 #(
    parameter N = 8
) (
    input  [N-1:0] a,
    input  [N-1:0] b,
    input  [N-1:0] c,
    input  [N-1:0] d,
    output [N-1:0] dout,
    input  [  1:0] sel
);

  logic [DATA_WIDTH-1:0] m00_o;
  logic [DATA_WIDTH-1:0] m01_o;

  mux #(
      .N(DATA_WIDTH)
  ) m00 (
      .a(a),
      .b(b),
      .dout(m00_o),
      .sel(sel[0])
  );

  mux #(
      .N(DATA_WIDTH)
  ) m01 (
      .a(c),
      .b(d),
      .dout(m01_o),
      .sel(sel[0])
  );

  mux #(
      .N(DATA_WIDTH)
  ) m10 (
      .a(m00_o),
      .b(m01_o),
      .dout(e),
      .sel(sel[1])
  );



endmodule : mux_4
