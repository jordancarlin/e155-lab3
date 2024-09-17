module counter #(parameter THRESHOLD = 1000) (
  input  logic       clk, reset,
  output logic       clk_stb
);

  logic [31:0] counter;

//   // Generate slower clock signal
  always_ff @(posedge clk)
    clk_stb <= (counter == THRESHOLD-1'b1);

  // Toggle the slow clock when the counter reaches the threshold
  always_ff @(posedge clk) begin
    if (~reset | clk_stb)
      counter <= 0;
    else
      counter <= counter + 1;
  end

endmodule