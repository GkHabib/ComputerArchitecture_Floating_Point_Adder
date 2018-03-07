
module udCounter(clk, rst, ld_exp, cen_exp, parin_exp, exp_out);
  input clk, rst, ld_exp, cen_exp;
  input[7:0] parin_exp;
  output reg[7:0] exp_out;

  always@(posedge clk) begin
    if(rst)
      exp_out <= 8'b0;
    else if(ld_exp)
      exp_out <= parin_exp;
    else if(cen_exp)
      exp_out <= 8'b0;
    else
      exp_out <= exp_out;
  end
endmodule
