/**
 * File              : uart_rx.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 06.04.2026
 * Last Modified Date: 06.04.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module uart_rx #(
    parameter BAUDIOS = 9600,
    parameter CLK_HZ  = 100000000
) (
    input clk,
    input rst,
    input rx,
    output [7:0] dout,
    output logic busy,
    output logic done
);

  localparam CICLOS_PERIODO = CLK_HZ / BAUDIOS;

  //shift register
  logic rx_shift_r;
  logic rx_w;
  shift_register #(
      .DATA_WIDTH(8)
  ) rx_register_impl (
      .clk(clk),
      .cl(rst),
      .w(rx_w),
      .shift_r(rx_shift_r),
      .shift_l(0),
      .i_bit(rx),
      .din(0),
      .dout(dout),
      .o_bit()
  );

  //contador de muestreo
  logic sampling_rst;
  logic [$clog2(CICLOS_PERIODO):0] sampling_counter_dout;
  counter #(
      .DATA_WIDTH($clog2(CICLOS_PERIODO) + 1)
  ) sampling_counter_impl (
      .clk (clk),
      .rst (sampling_rst),
      .up  (1'b1),
      .down(0),
      .din (0),
      .dout(sampling_counter_dout)
  );

  //contador de bits
  logic [2:0] bits_counter_dout;
  logic bits_counter_up;
  logic bits_counter_rst;
  counter #(
      .DATA_WIDTH(3)
  ) counter_bits_impl (
      .clk (clk),
      .rst (bits_counter_rst),
      .up  (bits_counter_up),
      .down(0),
      .din (0),
      .dout(bits_counter_dout)
  );


  localparam IDLE = 0;
  localparam START_BIT = 1;
  localparam DATA_BITS = 2;
  localparam STOP_BIT = 3;
  localparam DONE = 4;

  logic [2:0] current_state, next_state;

  always_comb begin
    next_state = current_state;
    sampling_rst = 0;
    rx_shift_r = 0;
    busy = 0;
    bits_counter_up = 0;
    bits_counter_rst = 0;
    rx_w = 0;
    done = 0;

    case (current_state)
      IDLE: begin
        sampling_rst = 1;
        bits_counter_rst = 1;
        if (rx == 0) begin
          rx_w = 1;
          next_state = START_BIT;
        end
      end
      START_BIT: begin
        busy = 1;
        if (sampling_counter_dout == (CICLOS_PERIODO >> 1)) begin
          next_state   = DATA_BITS;
          sampling_rst = 1;
        end
      end
      DATA_BITS: begin
        busy = 1;
        if (sampling_counter_dout == CICLOS_PERIODO) begin
          sampling_rst = 1;
          rx_shift_r = 1;
          bits_counter_up = 1;
          if (bits_counter_dout == 7) begin
            next_state = STOP_BIT;
          end
        end
      end
      STOP_BIT: begin
        busy = 1;
        if (sampling_counter_dout == CICLOS_PERIODO) begin
          next_state = DONE;
        end
      end
      DONE: begin
        done = 1;
        next_state = IDLE;
      end
    endcase

  end


  always_ff @(posedge clk) begin
    if (rst) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end

  end



endmodule : uart_rx
