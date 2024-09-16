// key_scan.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// Matrix keypad scanner

module key_scan #(parameter DELAY = 100) (
  input  logic       clk, reset,
  input  logic [3:0] cols,
  output logic       newNum,
  output logic [3:0] rows
);

  // Internal logic
  logic [31:0] counter;
  logic        delayed, clearCounter;

  // FSM states
  typedef enum logic [3:0] { IDLE, R0, R1, R2, R3, PRESSED, WAIT } statetype;
  statetype state, nextstate;

  always_ff @( posedge clk )
    if (reset) state <= IDLE;
    else       state <= nextstate;

  // Next state logic
  always_comb
    case(state)
      IDLE: nextstate = R0;
      R0:
        if (|cols) nextstate = PRESSED;
        else nextstate = R1;
      R1:
        if (|cols) nextstate = PRESSED;
        else nextstate = R2;
      R2:
        if (|cols) nextstate = PRESSED;
        else nextstate = R3;
      R3:
        if (|cols) nextstate = PRESSED;
        else nextstate = R0;
      PRESSED: nextstate = WAIT;
      WAIT:
        if (counter >= DELAY) nextstate = IDLE;
        else nextstate = WAIT;
      default: nextstate = IDLE;
    endcase

  // Output logic
  always_comb begin
    rows = '0;
    newNum = 0;
    delayed = 0;
    clearCounter = 0;
    /* verilator lint_off CASEINCOMPLETE */
    case(state)
      IDLE:    clearCounter = 1;
      R0:      rows = 4'b0001;
      R1:      rows = 4'b0010;
      R2:      rows = 4'b0100;
      R3:      rows = 4'b1000;
      PRESSED: newNum = 1;
      WAIT:    delayed = 1;
    endcase
    /* verilator lint_on CASEINCOMPLETE */
  end

  // Counter for delay
  always_ff @(posedge clk)
    if (reset | clearCounter) counter <= 0;
    else if (delayed) counter <= counter + 1;

endmodule
