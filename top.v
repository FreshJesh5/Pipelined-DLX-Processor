module top (
input clk, // clock
input rst  // synchronous reset active high
);

wire [31:0] sramA, sramD, instrA, instrD;
wire sramWe, sramRe;

instructionMemory instMem (.address(instrA), .instruction(instrD));

SRAM sram(.clk(clk), .address(sramA), .data(sramD), .we(sramWe), .re(sramRe));

CPU cpu (
.clk    (clk       ),
.rst    (rst     ),
.sramA  (sramA),
.sramData  (sramD),
.sramWe (sramWe),
.sramRe (sramRe),
.instrA (instrA),
.instrD (instrD)
);

endmodule