`timescale 1ns/1ns
module datapath(parin_s_A, parin_s_B, parin_exp_A, parin_exp_B, parin_shift_A, parin_shift_B, operator , clk, rst, ld_s_A, ld_exp_A, ld_man_A, ld_s_B, ld_exp_B, ld_man_B, eq_exp, lt_exp, gt_exp, eq_man, lt_man, gt_man,
   count_en_up_A, count_en_up_B, shift_man_right_A, shift_man_right_B, ld_exp_R, sel_sign_R, signA_xor_signB, samesign,
   ld_s_R, ld_man_R, co_sum, shift_man_right_R, shift_man_left_R, count_en_up_R, count_en_down_R, or_man_R, most_sig_man_R);

  output eq_exp, lt_exp, gt_exp, eq_man, lt_man, gt_man, signA_xor_signB, co_sum, most_sig_man_R,
  or_man_R;
  input clk, rst, ld_s_A, ld_s_B, ld_s_R, ld_man_A, ld_man_B, ld_man_R, ld_exp_A, ld_exp_B, ld_exp_R,
  count_en_up_A, count_en_up_B, count_en_up_R, count_en_down_R, shift_man_right_A, shift_man_right_B,
  shift_man_right_R, shift_man_left_R;

  input parin_s_A, parin_s_B, operator;
  input [7:0] parin_exp_A, parin_exp_B;
  input [23:0] parin_mant_A, parin_mant_B;

  wire s_outA, s_outB;
  wire [7:0] exp_outA, exp_outB;
  wire [23:0] mant_outA, mant_outB;

  flipFlop S_A(.clk(clk), .rst(rst), .ld_s(ld_s_A), .parin_s(parin_s_A), .s_out(s_outA));
  udCounter EXP_A(.clk(clk), .rst(rst), .ld_exp(ld_exp_A), .cen_up_exp(count_en_up_A), .cen_down_exp(1'b0), .parin_exp(parin_exp_A), .exp_out(exp_outA));
  shiftReg24 MANT_A(.clk(clk), .rst(rst), .ld_mantice(ld_man_A), .shift_right(shift_man_right_A), .shift_left(1'b0), .parin_mantice(parin_mant_A), .mantice_out(mant_outA));

  flipFlop S_B(.clk(clk), .rst(rst), .ld_s(ld_s_B), .parin_s(parin_s_B), .s_out(s_outB));
  udCounter EXP_B(.clk(clk), .rst(rst), .ld_exp(ld_exp_B), .cen_up_exp(count_en_up_B), .cen_down_exp(1'b0), .parin_exp(parin_exp_B), .exp_out(exp_outB));
  shiftReg24 MANT_B(.clk(clk), .rst(rst), .ld_mantice(ld_man_B), .shift_right(shift_man_right_B), .shift_left(1'b0), .parin_mantice(parin_mant_B), .mantice_out(mant_outB));

  comparator8 COMP_EXP(.a(exp_outA), .b(exp_outB), .lt(lt_exp), .eq(eq_exp), .gt(gt_exp));
  
