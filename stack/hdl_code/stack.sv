/**
 * @ Author: German Cano Quiveu, germancq
 * @ Create Time: 2022-09-21 12:12:32
 * @ Modified by: German Cano Quiveu, germancq
 * @ Modified time: 2022-09-21 13:43:23
 * @ Description:
 */

module stack_fifo #(
    parameter DEPTH = 8,
    parameter WIDTH = 8
) (
    input clk,
    input rst,
    input [WIDTH-1:0] data_i,
    output logic [WIDTH-1:0] data_o,
    input push,
    input pop,
    output empty,
    output full
);

  logic [$clog2(DEPTH):0] sp;
  logic [WIDTH-1:0] stack[DEPTH-1:0];

  assign empty = (sp == 0 ? 1 : 0);
  assign full  = (sp == DEPTH ? 1 : 0);

  always_ff @(posedge clk) begin
    if (rst) begin
      sp <= 0;
      data_o <= 0;
    end else if (push) begin
      if (full == 0) begin
        sp <= sp + 1;
        stack[sp] <= data_i;
      end
    end else if (pop) begin
      if (empty == 0) begin
        sp <= sp - 1;
        data_o <= stack[sp-1];
      end
    end
  end


endmodule : stack_fifo


module stack_fifo_sp #(
    parameter DEPTH = 8,
    parameter WIDTH = 8
) (
    input clk,
    input rst,
    input [WIDTH-1:0] data_i,
    output logic [WIDTH-1:0] data_o,
    input push,
    input pop,
    output empty,
    output full,
    output [$clog2(DEPTH):0] sp_index
);

  logic [$clog2(DEPTH):0] sp;
  logic [WIDTH-1:0] stack[DEPTH-1:0];

  assign empty = (sp == 0 ? 1 : 0);
  assign full = (sp == DEPTH ? 1 : 0);
  assign sp_index = sp;

  always_ff @(posedge clk) begin
    if (rst) begin
      sp <= 0;
      data_o <= 0;
    end else if (push) begin
      if (full == 0) begin
        sp <= sp + 1;
        stack[sp] <= data_i;
      end
    end else if (pop) begin
      if (empty == 0) begin
        sp <= sp - 1;
        data_o <= stack[sp-1];
      end
    end
  end


endmodule : stack_fifo_sp

module stack #(
    parameter FIFO_LIFO = 0,
    parameter DEPTH = 8,
    parameter WIDTH = 8
) (
    input clk,
    input rst,
    input [WIDTH-1:0] data_i,
    output logic [WIDTH-1:0] data_o,
    input push,
    input pop,
    output empty,
    output full,
    output [$clog2(DEPTH):0] sp_index
);

  logic [$clog2(DEPTH):0] sp;
  logic [WIDTH-1:0] stack[DEPTH-1:0];
  assign sp_index = sp;

  assign empty = (sp == 0 ? 1 : 0);
  assign full = (sp == DEPTH ? 1 : 0);

  logic [15:0] i;
  always_ff @(posedge clk) begin
    if (rst) begin
      sp <= 0;
      data_o <= 0;
    end else if (push) begin
      if (full == 0) begin
        sp <= sp + 1;
        stack[sp] <= data_i;
      end
    end else if (pop) begin
      if (empty == 0) begin
        if (FIFO_LIFO == 1) begin
          sp <= sp - 1;
          data_o <= stack[sp-1];
        end else begin
          sp <= sp - 1;
          data_o <= stack[0];
          for (i = 0; i < DEPTH - 1; i++) begin
            stack[i] <= stack[i+1];
          end
        end
      end
    end
  end


endmodule : stack
