// sync.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// Synchronizer for asynchronous inputs

module sync #(parameter WIDTH=4) (
  input  logic       clk, reset,
  input  logic [WIDTH-1:0] async,
  output logic [WIDTH-1:0] synced
);

  logic [WIDTH-1:0] sync1;

  always_ff @(posedge clk) begin
    if (~reset) begin
      sync1  <= '0;
      synced <= '0;
    end else begin
      sync1  <= async;
      synced <= sync1;
    end
  end

endmodule
