`timescale 1ns/1ns
module controller(CLK, rst, start, done, ld_s_A, ld_exp_A, ld_man_A, ld_s_B, ld_exp_B, ld_man_B, eq_exp, lt_exp, gt_exp, eq_man, lt_man, gt_man,
   count_en_up_A, count_en_up_B, shift_man_right_A, shift_man_right_B, ld_exp_R, sel_sign_R, signA_xor_signB, samesign,
   ld_s_R, ld_man_R, co_sum, shift_man_right_R, shift_man_left_R, count_en_up_R, count_en_down_R, or_man_R, most_sig_man_R);

   input CLK, rst, start, eq_exp, lt_exp, gt_exp, eq_man, lt_man, gt_man, signA_xor_signB, co_sum, most_sig_man_R
    or_man_R;
   output done, ld_s_A, ld_s_B, ld_s_R, ld_man_A, ld_man_B, ld_man_R, ld_exp_A, ld_exp_B, ld_exp_R,
    count_en_up_A, count_en_up_B, count_en_up_R, count_en_down_R, shift_man_right_A, shift_man_right_B,
    shift_man_right_R, shift_man_left_R, samesign;
    output [1:0] sel_sign_R;
    logic [3:0] ps,ns;
    parameter [3:0] IDLE=0, starting=1, loading=2, start_comparing_exp=3, load_result_exp=4, load_result_sign_man=5,
     check_carry_of_result_man=6, check_for_zero=7, check_for_msb_of_result=8;
    always@(start, eq_exp, co_sum, or_man_R, most_sig_man_R) begin
      case(ps)
        IDLE: begin ns=(start)? starting:IDLE; end
        starting:begin ns=(start)? starting:loading; end
        loading: begin ns=start_comparing_exp; end
        start_comparing_exp:begin ns=(eq_exp)? load_result_exp:start_comparing_exp; end
        load_result_exp: begin ns=load_result_sign_man; end
        load_result_sign_man: begin ns=(co_sum)? check_carry_of_result_man:check_for_zero; end
        check_carry_of_result_man: begin ns=check_for_zero; end
        check_for_zero: begin ns=(or_man_R)? check_for_msb_of_result:IDLE; end
        check_for_msb_of_result: begin ns=(most_sig_man_R)? IDLE:check_for_msb_of_result; end
        default: begin ns = IDLE; end
        endcase
    end
    always@(ps) begin
      done=0; ld_s_A=0; ld_s_B=0; ld_s_R=0; ld_man_A=0; ld_man_B=0; ld_man_R=0; ld_exp_A=0; ld_exp_B=0; ld_exp_R=0;
      count_en_up_A=0; count_en_up_B=0; count_en_up_R=0; count_en_down_R=0; shift_man_right_A=0; shift_man_right_B=0;
      shift_man_right_R=0; shift_man_left_R=0; samesign=0; sel_sign_R=2'b0;
      case(ps)
        IDLE: begin done=1; end
        starting:begin  end
        loading: begin ld_s_A=1; ld_exp_A=1; ld_man_A=1; ld_s_B=1; ld_exp_B=1; ld_man_B=1; end
        start_comparing_exp:begin if(lt_exp)begin count_en_up_A=1; shift_man_right_A=1; end else begin count_en_up_B=1; shift_man_right_B=1; end end
        load_result_exp: begin
            ld_exp_R=1;
            if(signA_xor_signB)begin
              if(lt_man) begin sel_sign_R = 2'b10; end
              else begin
                if(gt_man) begin sel_sign_R = 2'b01; end
                else begin sel_sign_R=2'b00; end
              end
            end
          end
        load_result_sign_man: begin ld_s_R=1; ld_man_R=1; end
        check_carry_of_result_man: begin shift_man_right_R=1; count_en_up_R=1; end
        check_for_zero: begin  end
        check_for_msb_of_result: begin count_en_down_R=1; shift_man_left_R=1; end
        default: begin done=0; ld_s_A=0; ld_s_B=0; ld_s_R=0; ld_man_A=0; ld_man_B=0; ld_man_R=0; ld_exp_A=0; ld_exp_B=0;
        ld_exp_R=0; count_en_up_A=0; count_en_up_B=0; count_en_up_R=0; count_en_down_R=0; shift_man_right_A=0; shift_man_right_B=0;
        shift_man_right_R=0; shift_man_left_R=0; samesign=0; sel_sign_R=2'b0; end
      endcase
  end
  always@(posedge CLK, posedge rst) begin
    if(rst) ps=IDLE;
    else ps = ns;
  end
  assign samesign=signA_xor_signB;

  endmodule
