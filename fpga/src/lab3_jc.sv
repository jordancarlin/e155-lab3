// lab3_jc.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// FPGA implementation for E155 Lab 3

module lab3_jc (
	input  logic 			 reset,
  input  logic [3:0] cols,
	output logic [3:0] rows,
  output logic [6:0] segs,
  output logic       disp0, disp1
);

	logic clk;

	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

	// Main verilog module
	top top (.*);
endmodule
