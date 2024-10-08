// top.sv
// Jordan Carlin, jcarlin@hmc.edu, 7 September 2024
// Top-level module for the E155 Lab 3 FPGA design

module top (
  input  logic       clk, reset,
  input  logic [3:0] cols,
  output logic [3:0] rows,
  output logic [6:0] segs,
  output logic       disp0, disp1,
  output logic       newNum,
  output logic       scanning, waiting, outCols
);

  // Internal logic
  logic       fsm_clk;
  logic [3:0] syncedCols;
  logic [3:0] num, num0, num1, numOut;

  // slower clock for rest of system
  counter #(4800) counter(.clk, .reset, .clk_stb(fsm_clk));

  // Read keypad
  sync sync(.clk(fsm_clk), .reset, .async(cols), .synced(syncedCols));
  key_scan key_scan(.clk(fsm_clk), .reset, .cols(syncedCols), .rows, .newNum, .scanning, .waiting);

  // Determine number based on which key is pressed
  key_decoder key_decoder(.rows, .cols(syncedCols), .num);

  // Hold numbers until new number pressed and shift old number
  always_ff @(posedge fsm_clk, negedge reset) begin
    if (~reset) begin
      num0 <= '0;
      num1 <= '0;
    end else if (newNum) begin
      num0 <= num;
      num1 <= num0;
    end
  end

  // Toggle active display
  pulse #(50) pulse(.clk(fsm_clk), .reset, .num0, .num1, .numOut, .disp0, .disp1);

  // Seven-segment display decoder
  seg_decoder seg_decoder(.num(numOut), .segs);

  // Debug signals
  assign outCols = |cols;

endmodule
