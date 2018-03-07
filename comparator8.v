`timescale 1ns/1ns

module comparator8(a, b, lt, eq, gt);
  input[7:0] a, b;
  output lt, eq, gt;

  assign lt = (a < b);
  assign eq = (a == b);
  assign gt = (a > b);
endmodule
