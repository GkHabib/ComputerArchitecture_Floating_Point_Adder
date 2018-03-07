`timescale 1ns/1ns
module datapath(parin_s_A, parin_s_B, parin_exp_A, parin_exp_B, parin_mant_A, parin_mant_B, operator, s_outR, exp_outR, mant_outR,
   clk, rst, ld_s_A, ld_exp_A, ld_man_A, ld_s_B, ld_exp_B, ld_man_B, eq_exp, lt_exp, gt_exp, eq_man, lt_man, gt_man,
   count_en_up_A, count_en_up_B, shift_man_right_A, shift_man_right_B, ld_exp_R, sel_sign_R, signA_xor_signB, samesign,
   ld_s_R, ld_man_R, co_sum, shift_man_right_R, shift_man_left_R, count_en_up_R, count_en_down_R, or_man_R, most_sig_man_R);

  output eq_exp, lt_exp, gt_exp, eq_man, lt_man, gt_man, signA_xor_signB, co_sum, most_sig_man_R, or_man_R;
  output s_outR;
  output [7:0] exp_outR;
  output [23:0] mant_outR;

  input clk, rst, ld_s_A, ld_s_B, ld_s_R, ld_man_A, ld_man_B, ld_man_R, ld_exp_A, ld_exp_B, ld_exp_R,
    count_en_up_A, count_en_up_B, count_en_up_R, count_en_down_R, shift_man_right_A, shift_man_right_B,
    shift_man_right_R, shift_man_left_R, samesign;
  input [1:0] sel_sign_R;

  input parin_s_A, parin_s_B, operator;
  input [7:0] parin_exp_A, parin_exp_B;
  input [23:0] parin_mant_A, parin_mant_B;

  wire s_outA, s_outB;
  wire [7:0] exp_outA, exp_outB;
  wire [23:0] mant_outA, mant_outB;

  wire parin_s_R;
  wire [23:0] parin_mant_R;

  flipFlop S_A(.clk(clk), .rst(rst), .ld_s(ld_s_A), .parin_s(parin_s_A), .s_out(s_outA));
  udCounter EXP_A(.clk(clk), .rst(rst), .ld_exp(ld_exp_A), .cen_up_exp(count_en_up_A), .cen_down_exp(1'b0), .parin_exp(parin_exp_A), .exp_out(exp_outA));
  shiftReg24 MANT_A(.clk(clk), .rst(rst), .ld_mantice(ld_man_A), .shift_right(shift_man_right_A), .shift_left(1'b0), .parin_mantice(parin_mant_A), .mantice_out(mant_outA), .serin_from_left(1'b0));

  flipFlop S_B(.clk(clk), .rst(rst), .ld_s(ld_s_B), .parin_s(parin_s_B ^ operator), .s_out(s_outB));
  udCounter EXP_B(.clk(clk), .rst(rst), .ld_exp(ld_exp_B), .cen_up_exp(count_en_up_B), .cen_down_exp(1'b0), .parin_exp(parin_exp_B), .exp_out(exp_outB));
  shiftReg24 MANT_B(.clk(clk), .rst(rst), .ld_mantice(ld_man_B), .shift_right(shift_man_right_B), .shift_left(1'b0), .parin_mantice(parin_mant_B), .mantice_out(mant_outB), .serin_from_left(1'b0));

  comparator8 COMP_EXP(.a(exp_outA), .b(exp_outB), .lt(lt_exp), .eq(eq_exp), .gt(gt_exp));
  comparator24 COMP_MAN(.a(mant_outA), .b(mant_outB), .lt(lt_man), .eq(eq_man), .gt(gt_man));

  xor(signA_xor_signB, s_outA, s_outB);

  wire [23:0] sum_man_AB;
  adder24 ADDER_MAN_AB(.a(mant_outA), .b(mant_outB), .sum(sum_man_AB), .co(co_sum));

  wire [23:0] sub_man_AB;
  subtractor24 SUB_MAN_AB(.a(mant_outA), .b(mant_outB), .sub(sub_man_AB));

  mux2to1 MUX_ON_MANT(.a(sum_man_AB), .b(sub_man_AB), .select(samesign), .mux_out(parin_mant_R));

  mux4to1 MUX_ON_SIGN(.a(1'b0), .b(s_outA), .c(s_outB), .d(1'b1), .select(sel_sign_R), .mux_out(parin_s_R));

  flipFlop S_R(.clk(clk), .rst(rst), .ld_s(ld_s_R), .parin_s(parin_s_R), .s_out(s_outR));
  udCounter EXP_R(.clk(clk), .rst(rst), .ld_exp(ld_exp_R), .cen_up_exp(count_en_up_R), .cen_down_exp(count_en_down_R), .parin_exp(exp_outA), .exp_out(exp_outR));
  shiftReg24 MANT_R(.clk(clk), .rst(rst), .ld_mantice(ld_man_R), .shift_right(shift_man_right_R), .shift_left(shift_man_left_R), .parin_mantice(parin_mant_R), .mantice_out(mant_outR), .serin_from_left(1'b1));
  assign most_sig_man_R = mant_outR[23];
  assign or_man_R = |{mant_outR};


endmodule
