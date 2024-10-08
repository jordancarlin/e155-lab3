// key_scan.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// Matrix keypad scanner FSM

module key_scan #(parameter DELAY = 300, parameter DEBOUNCE=15, parameter SYNC_DELAY = 2) (
  input  logic       clk, reset,
  input  logic [3:0] cols,
  output logic       newNum,
  output logic [3:0] rows,
  output logic       scanning, waiting
);

  // Internal logic
  logic [31:0] counter;
  logic        incCount, clearCounter, rowChange;
  logic [3:0]  newRows;

  // FSM states
  typedef enum logic [3:0] { IDLE, R0, R1, R2, R3, R0_CHECK, R1_CHECK, R2_CHECK, R3_CHECK, POSSIBLE_PRESSED, PRESSED, WAIT } statetype;
  statetype state, nextstate;

  // State register
  always_ff @( posedge clk, negedge reset)
    if (~reset) state <= IDLE;
    else state <= nextstate;
  
  // Retain current row for key_decoder unless deliberately changing rows based on state
  always_ff @(posedge clk, negedge reset)
    if (~reset) rows <= '0;
    else if	(rowChange) rows <= newRows;

  // Counter used by several state transitions
  always_ff @(posedge clk)
    if (clearCounter) counter <= 0;
    else if (incCount) counter <= counter + 1;

  // Next state logic
  always_comb
    case(state)
      IDLE: nextstate = R0;
      R0: nextstate = R0_CHECK;
      R0_CHECK:
        if (|cols) nextstate = POSSIBLE_PRESSED;
        else if (counter >= SYNC_DELAY) nextstate = R1;
        else nextstate = R0_CHECK;
      R1: nextstate = R1_CHECK;
      R1_CHECK:
        if (|cols) nextstate = POSSIBLE_PRESSED;
        else if (counter >= SYNC_DELAY) nextstate = R2;
        else nextstate = R1_CHECK;
      R2: nextstate = R2_CHECK;
      R2_CHECK:
        if (|cols) nextstate = POSSIBLE_PRESSED;
        else if (counter >= SYNC_DELAY) nextstate = R3;
        else nextstate = R2_CHECK;
      R3: nextstate = R3_CHECK;
      R3_CHECK:
        if (|cols) nextstate = POSSIBLE_PRESSED;
        else if (counter >= SYNC_DELAY) nextstate = R0;
        else nextstate = R3_CHECK;
      POSSIBLE_PRESSED:
        if (counter >= DEBOUNCE) 
          if (|cols) nextstate = PRESSED;
          else nextstate = IDLE;
        else nextstate = POSSIBLE_PRESSED;
      PRESSED: nextstate = WAIT;
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
    incCount = 0;
    clearCounter = 0;
    rowChange = 0;
    /* verilator lint_off CASEINCOMPLETE */
    case(state)
      IDLE:    clearCounter = 1;
      R0:      begin
        newRows = 4'b0001;
        rowChange = 1;
        clearCounter = 1;
      end
      R1:      begin
        newRows = 4'b0010;
        rowChange = 1;
        clearCounter = 1;
      end
      R2:      begin
        newRows = 4'b0100;
        rowChange = 1;
        clearCounter = 1;
      end
      R3:      begin
        newRows = 4'b1000;
        rowChange = 1;
        clearCounter = 1;
      end
      R0_CHECK: incCount = 1;
      R1_CHECK: incCount = 1;
      R2_CHECK: incCount = 1;
      R3_CHECK: incCount = 1;
      POSSIBLE_PRESSED: incCount = 1;
      PRESSED: newNum = 1;
      WAIT:    incCount = 1;
    endcase
    /* verilator lint_on CASEINCOMPLETE */
  end

  // debug signals
	assign scanning = (state == R0) | (state == R1) | (state == R2) | (state == R3);
	assign waiting = (state == WAIT);
	
endmodule
