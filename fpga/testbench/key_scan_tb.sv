// key_scan_tb.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// Testbench for the matrix keypad scanner

`timescale 1ns/1ns
`default_nettype none
`define N_TV 17

module key_scan_tb();
  // Set up test signals
  logic        clk, reset;
  logic [3:0]  cols, rows, rowsExpected;
  logic        newNum, newNumExpected;
  // logic [31:0] vectornum, errors;
  // logic [11:0] testvectors[10000:0]; // Vectors of format rows[3:0]_cols[3:0]_num[3:0]

  // Instantiate the device under test
  key_scan dut(.*);

  // Generate clock signal with a period of 10 timesteps.
  always begin
    clk <= 1; #5;
    clk <= 0; #5;
  end
  
  // At the start of the simulation:
  //  - Load the testvectors
  //  - Pulse the reset line (if applicable)
  initial begin
    cols = '0;
    reset = 0; #22;
    reset = 1; #100;
    cols[0] = 1; #50;
    cols[0] = 0; #100;
    cols[1] = 1; #30;
    cols[1] = 0; #100;
    cols[2] = 1; #15;
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
