`timescale 1ns/1ns

module udCounter(clk, rst, ld_exp, cen_up_exp, cen_down_exp, parin_exp, exp_out);
  input clk, rst, ld_exp, cen_up_exp, cen_down_exp;
  input[7:0] parin_exp;
  output reg[7:0] exp_out;

  always@(posedge clk) begin
    if(rst)
      exp_out <= 8'b0;
    else if(ld_exp)
      exp_out <= parin_exp;
    else if(cen_up_exp)
      exp_out <= exp_out + 1;
    else if(cen_down_exp)
      exp_out <= exp_out - 1;
    else
      exp_out <= exp_out;
  end
endmodule
