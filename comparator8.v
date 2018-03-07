`timescale 1ns/1ns

module comparator8(a, b, lt, eq, gt);
  input[7:0] a, b;
  output lt, eq, gt;

  assign lt = (a < b) ? 1'b1 : 1'b0;
  assign eq = (a == b) ? 1'b1 : 1'b0;
  assign gt = (a > b) ? 1'b1 : 1'b0;
endmodule
