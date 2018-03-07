`timescale 1ns/1ns

module TB();
  reg parin_s_A, parin_s_B;
  reg [7:0]  parin_exp_A, parin_exp_B;
  reg [23:0] parin_mant_A, parin_mant_B;
  reg operator;
  wire s_outR;
  wire [7:0] exp_outR;
  wire [23:0] mant_outR;
  reg clk, rst;
  wire ld_s_A, ld_exp_A, ld_man_A, ld_s_B, ld_exp_B, ld_man_B, eq_exp, lt_exp, gt_exp, eq_man, lt_man, gt_man,
    count_en_up_A, count_en_up_B, shift_man_right_A, shift_man_right_B, ld_exp_R, signA_xor_signB, samesign,ld_s_R,
    ld_man_R, co_sum, shift_man_right_R, shift_man_left_R, count_en_up_R, count_en_down_R, or_man_R, most_sig_man_R;
  wire [1:0] sel_sign_R;
  reg start=0, done;


  datapath dp(.parin_s_A(parin_s_A), .parin_s_B(parin_s_B), .parin_exp_A(parin_exp_A), .parin_exp_B(parin_exp_B), .parin_mant_A(parin_mant_A), .parin_mant_B(parin_mant_B), .operator(operator), .s_outR(s_outR), .exp_outR(exp_outR), .mant_outR(mant_outR),
    .clk(clk), .rst(rst), .ld_s_A(ld_s_A), .ld_exp_A(ld_exp_A), .ld_man_A(ld_man_A), .ld_s_B(ld_s_B), .ld_exp_B(ld_exp_B), .ld_man_B(ld_man_B), .eq_exp(eq_exp), .lt_exp(lt_exp), .gt_exp(gt_exp), .eq_man(eq_man), .lt_man(lt_man), .gt_man(gt_man),
    .count_en_up_A(count_en_up_A), .count_en_up_B(count_en_up_B), .shift_man_right_A(shift_man_right_A), .shift_man_right_B(shift_man_right_B), .ld_exp_R(ld_exp_R), .sel_sign_R(sel_sign_R), .signA_xor_signB(signA_xor_signB), .samesign(samesign),
    .ld_s_R(ld_s_R), .ld_man_R(ld_man_R), .co_sum(co_sum), .shift_man_right_R(shift_man_right_R), .shift_man_left_R(shift_man_left_R), .count_en_up_R(count_en_up_R), .count_en_down_R(count_en_down_R), .or_man_R(or_man_R), .most_sig_man_R(most_sig_man_R));

  controller cu(.clk(clk), .rst(rst), .start(start), .done(done), .ld_s_A(ld_s_A), .ld_exp_A(ld_exp_A), .ld_man_A(ld_man_A), .ld_s_B(ld_s_B), .ld_exp_B(ld_exp_B), .ld_man_B(ld_man_B), .eq_exp(eq_exp), .lt_exp(lt_exp), .gt_exp(gt_exp), .eq_man(eq_man), .lt_man(lt_man), .gt_man(gt_man),
    .count_en_up_A(count_en_up_A), .count_en_up_B(count_en_up_B), .shift_man_right_A(shift_man_right_A), .shift_man_right_B(shift_man_right_B), .ld_exp_R(ld_exp_R), .sel_sign_R(sel_sign_R), .signA_xor_signB(signA_xor_signB), .samesign(samesign),
    .ld_s_R(ld_s_R), .ld_man_R(ld_man_R), .co_sum(co_sum), .shift_man_right_R(shift_man_right_R), .shift_man_left_R(shift_man_left_R), .count_en_up_R(count_en_up_R), .count_en_down_R(count_en_down_R), .or_man_R(or_man_R), .most_sig_man_R(most_sig_man_R));

initial begin
  parin_s_A=0;
  parin_exp_A  = 8'b00000001;
  parin_mant_A = 24'b100000000000000000000000;
  parin_s_B=0;
  parin_exp_B  = 8'b00000001;
  parin_mant_B = 24'b100000000000000000000000;
  operator = 0;
  #100;
  start = 1;
  #100;
  start = 0;
end
initial repeat(30) #100 clk = ~clk;
endmodule
