`timescale 1ns/1ns

module shiftReg24(clk, rst, ld_mantice, shift_right, shift_left, parin_mantice, mantice_out );
  input clk, rst, ld_mantice, shift_right, shift_left;
  input[23:0] parin_mantice;
  output reg[23:0] mantice_out;

  always@(posedge clk) begin
    if(rst)
      mantice_out <= 24'b0;
    else if(ld_mantice)
      mantice_out <= parin_mantice;
    else if(shift_right)
      mantice_out <= {1'b0, mantice_out[23:1]};
    else if(shift_left)
      mantice_out <= {mantice_out[22:0], 1'b0};
    else
      mantice_out <= mantice_out;
  end
endmodule
