// key_decoder_tb.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// Testbench for the matrix keypad decoder

`timescale 1ns/100ps
`default_nettype none
`define N_TV 17

module key_decoder_tb();
  // Set up test signals
  logic       clk;
  logic [3:0] rows, cols, num, numExpected;
  logic [31:0] vectornum, errors;
  logic [11:0] testvectors[10000:0]; // Vectors of format rows[3:0]_cols[3:0]_num[3:0]

  // Instantiate the device under test
  key_decoder dut(.*);

  // Generate clock signal with a period of 10 timesteps.
  always begin
    clk <= 1; #5;
    clk <= 0; #5;
  end
  
  // At the start of the simulation:
  //  - Load the testvectors
  //  - Pulse the reset line (if applicable)
  initial begin
    $readmemb("/home/jcarlin/e155/e155-lab3/fpga/testbench/key_decoder_testvectors.tv", testvectors, 0, `N_TV - 1);
    vectornum = 0; errors = 0;
  end

  // Apply test vector on the rising edge of clk
  always @(posedge clk) begin
    #1; {rows, cols, numExpected} <= testvectors[vectornum];
  end

  // Check results on the falling edge of clk
  always @(negedge clk) begin
    if (num !== numExpected) begin
      $display("Error: inputs: rows=%b, cols=%b", rows, cols);
      $display(" output: num=%b (%b expected)", num, numExpected);
      errors <= errors + 1;
    end

    vectornum <= vectornum + 1;
    if (testvectors[vectornum] === 12'bx) begin
      $display("%d tests completed with %d errors.", vectornum, errors);
      $stop;
    end
  end
endmodule
