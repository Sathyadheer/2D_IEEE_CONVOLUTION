`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2025 15:33:16
// Design Name: 
// Module Name: MULTIPLIER
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
module MULTIPLIER #(parameter N=32,M=23,E=8,B=127,O=255)( input [N-1:0]a,b,output reg [N-1:0]out, output reg ovrf, reg undrf );
reg sign ;
reg [E:0]exp ;
reg [(2*M+1):0]mant ;
reg [M-1:0]N_mant ;
reg [E-1:0]R_exp; 
always@ (*) begin
 sign = a[N-1]^b[N-1] ;
 exp = a[N-2:N-E-1] + b[N-2:N-E-1] - B  ;
 mant = {1'b1,a[M-1:0]} * {1'b1,b[M-1:0]} ;
           if ( mant[(2*M+1)] == 1 ) begin
                N_mant = mant[2*M:M+1] ;
                exp = exp + 1 ;
                end
            else begin
                N_mant = mant[2*M-1:M] ;
                exp = exp ;
                end
            if ( exp > O) begin
                R_exp = O ;
                N_mant = 0 ;
                 out = {sign,R_exp,N_mant } ;
                    ovrf = 1 ;
                    undrf =0;
                 end
           else if ( exp < 0) begin
                R_exp = 0;
                N_mant =0 ;
                out = {sign,R_exp,N_mant} ;
                undrf = 1 ;
                ovrf=0;
                end
          else 
               begin
               R_exp = exp[E-1:0] ;
                ovrf = 0;
                undrf = 0;
                   out ={sign,R_exp,N_mant} ;
           end
                        
  end


endmodule

