module mux4to1(a, b, c, d, select, mux_out);
  input a, b, c, d;
  input[1:0] select;
  output mux_out;

  assign mux_out = (select == 2'b00) ? a :
                    (select == 2'b01) ? b :
                    (select == 2'b10) ? c :
                    (select == 2'b11) ? d :
                    2'bx;
endmodule
