/**
 * File              : half_duplex.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module half_duplex (
    input  tx,
    output rx,
    input  tx_ocupado,
    input  rx_ocupado,
    input  iniciar,
    output transmitir,
    inout  linea
);
  assign rx = tx_ocupado == 1 ? 1 : (linea === 0) ? 0 : 1;
  assign transmitir = (tx_ocupado | rx_ocupado) == 1 ? 0 : iniciar;
  assign linea = tx_ocupado == 1 ? tx : 1'bz;
endmodule

