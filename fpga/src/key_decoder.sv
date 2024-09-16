// key_decoder.sv
// Jordan Carlin, jcarlin@hmc.edu, 15 September 2024
// Matrix keypad decoder

module key_decoder(
  input  logic [3:0] rows, cols,
  output logic [3:0] num
);

  always_comb
    case(rows)
      4'b0001:
        case(cols)
          4'b0001: num = 1;
          4'b0010: num = 2;
          4'b0100: num = 3;
          4'b1000: num = 10;
          default: num = 0;
        endcase
      4'b0010:
        case(cols)
          4'b0001: num = 4;
          4'b0010: num = 5;
          4'b0100: num = 6;
          4'b1000: num = 11;
          default: num = 0;
        endcase
      4'b0100:
        case(cols)
          4'b0001: num = 7;
          4'b0010: num = 8;
          4'b0100: num = 9;
          4'b1000: num = 12;
          default: num = 0;
        endcase
      4'b1000:
        case(cols)
          4'b0001: num = 14;
          4'b0010: num = 0;
          4'b0100: num = 15;
          4'b1000: num = 13;
          default: num = 0;
        endcase
      default: num = 0;
    endcase

endmodule
