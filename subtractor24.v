module subtractor24(a, b, sub);
  input[23:0] a, b;
  output[23:0] sub;
   
  assign sub = (a > b) ? a - b : b - a;
endmodule
