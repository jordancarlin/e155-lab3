// pulse.sv
// Jordan Carlin, jcarlin@hmc.edu, 7 September 2024
// Pulse module that toggles outputs based on a configuirable frequency signal

module pulse #(parameter THRESHOLD = 1000) (
  input  logic       clk, reset,
  input  logic [3:0] num0, num1,
  output logic [3:0] numOut,
  output logic       disp0, disp1
);

  // Internal signals
  logic clk_stb;

  // generate slower clock signal
  counter #(THRESHOLD) counter(.clk, .reset, .clk_stb);

  // Toggle the LED when the counter reaches the threshold
  always_ff @(posedge clk, negedge reset)
    if (~reset) begin
      disp0 <= 0;
      numOut <= '0;
    end else if (clk_stb) begin
      disp0 <= ~disp0;
      numOut <= disp0 ? num0 : num1;
  end

  // Only one display should be active
  assign disp1 = ~disp0;
endmodule
