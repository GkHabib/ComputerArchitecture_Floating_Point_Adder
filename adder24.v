module adder24(a, b, sum, co);
  input[23:0] a, b;
  output[23:0] sum;
  output co;

  assign {co, sum} = a + b;
endmodule
