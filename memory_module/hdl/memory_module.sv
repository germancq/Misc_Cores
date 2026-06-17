/**
 * File              : memory_module.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 03.04.2026
 * Last Modified Date: 03.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module memory_module #(
    parameter ADDR = 4,
    parameter DATA_WIDTH = 8,
    parameter FILE_MEM = "init.mem"
) (
    input clk,
    input we,
    input [ADDR-1:0] addr,
    input [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);

  logic [DATA_WIDTH-1:0] memory_[(2**ADDR)-1:0];

  initial begin
    $readmemh(FILE_MEM, memory_);
  end

  always_ff @(posedge clk) begin
    if (we) begin
      memory_[addr] <= din;
    end else begin
      dout <= memory_[addr];
    end

  end

endmodule : memory_module
