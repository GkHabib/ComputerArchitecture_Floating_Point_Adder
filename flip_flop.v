module flipFlop(clk, rst, ld_s, parin_s, s_out);
  input clk, rst, ld_s;
  input parin_s;
  output reg s_out;

  always@(posedge clk) begin
    if(rst)
      s_out <= 1'b0;
    else if(ld_s)
      s_out <= parin_s;
    else
      s_out <= s_out;
  end
endmodule
