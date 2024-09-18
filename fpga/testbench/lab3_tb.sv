// key_scan_tb.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// Testbench for lab 3

`timescale 1ns/1ns
`default_nettype none

module lab3_tb();
  // Set up test signals
  // `define HALF_PERIOD #10.4
  /* verilator lint_off UNUSEDSIGNAL */
  logic       clk, reset;
  logic [3:0] cols;
  logic [3:0] rows;
  logic [6:0] segs;
  logic       disp0, disp1;
  logic       newNum, scanning, waiting, outCols;
  /* verilator lint_on UNUSEDSIGNAL */

  // Instantiate the device under test
  top dut(.*);

  // Generate 48 MHz clock signal
  initial clk = 0;
  always #5 clk <= ~clk;
  
  // At the start of the simulation:
  //  - Pulse the reset line and apply tests values
  initial begin
    cols = '0;
    reset = 0; #22;
    reset = 1; #100;
    cols[0] = 1; #190;
    cols[0] = 0; #100;
    cols[1] = 1; #300;
    cols[1] = 0; #1000;
    cols[2] = 1; #150;
    cols[2] = 0; #100;
    cols[3] = 1; #100;
    cols[3] = 0; #100;
    $stop;
  end

  // // Check results on the falling edge of clk
  // always @(negedge clk) begin
  //   if (num !== num_expected) begin
  //     $display("Error: inputs: rows=%b, cols=%b", rows, cols);
  //     $display(" output: num=%b (%b expected)", num, num_expected);
  //     errors <= errors + 1;
  //   end
  // end
endmodule
