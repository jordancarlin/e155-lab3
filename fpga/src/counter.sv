// counter.sv
// Jordan Carlin, jcarlin@hmc.edu, 16 September 2024
// Counter for configurable output speed signal

module counter #(parameter THRESHOLD = 1000) (
  input  logic  clk, reset,
  output logic  clk_stb
);

  logic [31:0] count;

//   // Generate slower clock signal
  always_ff @(posedge clk)
    clk_stb <= (count == THRESHOLD-1'b1);

  // Toggle the slow clock when the counter reaches the threshold
  always_ff @(posedge clk, negedge reset) begin
    if (~reset | clk_stb)
      count <= 0;
    else
      count <= count + 1;
  end

endmodule
