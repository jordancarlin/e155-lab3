// key_scan.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// Matrix keypad scanner

module key_scan #(parameter DELAY = 20, parameter DEBOUNCE=10) (
  input  logic       clk, reset,
  input  logic [3:0] cols,
  output logic       newNum,
  output logic [3:0] rows
);

  // Internal logic
  logic [31:0] counter;
  logic        incCount, clearCounter, rowChange;
  logic [3:0]  newRows;

  // FSM states
  typedef enum logic [2:0] { IDLE, R0, R1, R2, R3, POSSIBLE_PRESSED, PRESSED, WAIT } statetype;
  statetype state, nextstate;

  always_ff @( posedge clk ) begin
    if (~reset) state <= IDLE;
    else state <= nextstate;
    if (rowChange) rows <= newRows;
  end

  // Next state logic
  always_comb
    case(state)
      IDLE: nextstate = R0;
      R0:
        if (|cols) nextstate = POSSIBLE_PRESSED;
        else nextstate = R1;
      R1:
        if (|cols) nextstate = POSSIBLE_PRESSED;
        else nextstate = R2;
      R2:
        if (|cols) nextstate = POSSIBLE_PRESSED;
        else nextstate = R3;
      R3:
        if (|cols) nextstate = POSSIBLE_PRESSED;
        else nextstate = R0;
      POSSIBLE_PRESSED:
        if (counter >= DEBOUNCE & |cols) nextstate = PRESSED;
        else if (|cols) nextstate = POSSIBLE_PRESSED;
        else nextstate = IDLE;
      WAIT:
        if (|cols) nextstate = WAIT;
        else if (counter >= DELAY) nextstate = IDLE;
        else nextstate = WAIT;
      default: nextstate = IDLE;
    endcase

  // Output logic
  always_comb begin
    newRows = '0;
    newNum = 0;
    incCounte = 0;
    clearCounter = 0;
    rowChange = 0;
    /* verilator lint_off CASEINCOMPLETE */
    case(state)
      IDLE:    clearCounter = 1;
      R0:      begin
        newRows = 4'b0001;
        rowChange = 1;
      end
      R1:      begin
        newRows = 4'b0010;
        rowChange = 1;
      end
      R2:      begin
        newRows = 4'b0100;
        rowChange = 1;
      end
      R3:      begin
        newRows = 4'b1000;
        rowChange = 1;
      end
      POSSIBLE_PRESSED: incCounter = 1;
      PRESSED: newNum = 1;
      WAIT:    incCounter = 1;
    endcase
    /* verilator lint_on CASEINCOMPLETE */
  end

  // Counter for delay
  always_ff @(posedge clk)
    if (clearCounter) counter <= 0;
    else if (incCounte) counter <= counter + 1;

endmodule
