`timescale 1ns/1ns

module mux2to1(a, b, select, mux_out);
  input[23:0] a, b;
  input select;
  output[23:0] mux_out;

  assign mux_out = select ? b : a;
endmodule
