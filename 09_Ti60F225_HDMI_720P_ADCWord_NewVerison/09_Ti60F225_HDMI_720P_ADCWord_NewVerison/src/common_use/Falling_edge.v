`timescale 1ns / 1ps
module Falling_edge (
    input                               clk                        ,
    input                               rst_n                      ,
    input  wire                         pre_signal                 ,

    output reg                         data_enable,
    output wire                         falling_edge               ,
    output wire                         widen_falling_edge         
    
    );

reg                                     delay_hsync                ;
reg                                     img1_hs_neg                ;
reg                                     img2_hs_neg                ;
always @(posedge clk or negedge rst_n)
   begin
         if( rst_n == 1'b0)
              delay_hsync <= 1'b0;
         else
              delay_hsync <= pre_signal;
    end
assign     falling_edge   =    delay_hsync & ~pre_signal;


always @(posedge clk or negedge rst_n)
   begin
    if(rst_n == 1'b0)begin
                
            img1_hs_neg<= 1'b0;
            img2_hs_neg<= 1'b0;
        end
    else begin
                
            img1_hs_neg <= falling_edge;
            img2_hs_neg <= img1_hs_neg;
        end
    end
assign     widen_falling_edge   = falling_edge|img1_hs_neg|img2_hs_neg;

always @(posedge clk or negedge rst_n)
   begin
         if( rst_n == 1'b0)
            data_enable <= 1'b0;
         else if (falling_edge) begin
            data_enable <= 1'b1;
            end
         else begin
            data_enable <= data_enable;
            end
         end
endmodule

