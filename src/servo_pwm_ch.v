`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 08:13:05 PM
// Design Name: 
// Module Name: servo_pwm_ch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module servo_pwm_ch(
    input wire clk,
    input wire rst,
    input wire ch_en,
    input wire io_enb,
    input wire [11:0] ch_pulse_width_ui,
    input wire pulse_sof,
    input wire pulse_ui,
    output reg ch_active,
    output wire ch_pwm_pin
    );

reg [11:0] pulse_width_cntr;
reg ch_pwm_out;
reg ch_pwm_t;
wire pulse_done;
wire ch_pulse_width_ui_nz;

//assign pulse_done        = (pulse_width_cntr == pulse_width_ui);
assign pulse_done           = (pulse_width_cntr == 0);
assign ch_pulse_width_ui_nz = (ch_pulse_width_ui != 0); 

always@(posedge clk)
begin
    casex({rst, ch_en, pulse_sof})
        3'b1xx: ch_active <= 1'b0;
        3'b011: ch_active <= 1'b1;
        3'b001: ch_active <= 1'b0;
        default: ch_active <= ch_active;
    endcase
        
    casex({rst, ch_en, pulse_sof, pulse_ui, pulse_done, ch_active})
        6'b1xxxxx,
        6'b001xxx,
        //6'b00001x,
        //6'b010011,
        6'b011xxx: pulse_width_cntr <= ch_pulse_width_ui;
        6'b000101,
        6'b01010x: pulse_width_cntr <= pulse_width_cntr - 1;
        default:   pulse_width_cntr <= pulse_width_cntr;
    endcase

    casex({rst, ch_en, pulse_sof & ch_pulse_width_ui_nz, pulse_done})
        4'b1xxx: ch_pwm_out <= 1'b0;
        4'b011x: ch_pwm_out <= 1'b1;
        4'b0101: ch_pwm_out <= 1'b0;
        4'b0001: ch_pwm_out <= 1'b0;
        default: ch_pwm_out <= ch_pwm_out; 
    endcase

    casex({rst, ch_en, io_enb, pulse_sof})
        4'b1xxx:  ch_pwm_t <= 1'b1;
        4'b010x:  ch_pwm_t <= 1'b0;
        4'b0011:  ch_pwm_t <= 1'b1;
        default: ch_pwm_t <= ch_pwm_t; 
    endcase
end    


servo_pwm_io_pin pwm_io_pin_inst(
    .pwm_t  (ch_pwm_t),
    .pwm_out(ch_pwm_out),
    .pwm_pin(ch_pwm_pin)
    );    
    
endmodule
