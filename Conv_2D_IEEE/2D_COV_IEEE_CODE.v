module IEEE #(parameter N=3,M=2)(
    input clk,rst,
    input [7:0] a,b,
    output  reg [7:0] out,
    output reg done
    );
    reg [7:0] A[0:N-1][0:N-1];
    reg [7:0] B[0:M-1][0:M-1];
    reg [31:0]temp1,temp2,p,t1;
    wire [31:0]t2,y;
    reg [3:0] ps,ns;
    localparam init=9,s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7,s8=8,s9=9;
    integer c1,c2,c3,c4,c5,c6;
    reg [7:0]sum=0;
    
    MULTIPLIER m4(temp1,tempe2, t2);
    ADDER a1(t1, t2,y);
    
    
    always@(posedge clk)
       begin
          if(rst)
          ps <= init;
          else
          ps<=ns;
      end
   always@(negedge clk)
      begin
        case(ps)
        init: begin
                c1<=0;
                c2<=0;
                c3<=0;
                c4<=0;
                c5<=0;
                c6<=0;
                done<=0;
                end
        s0:
             begin
                if(c1<M && c2<M) 
                begin
                    A[c1][c2] <= a;
                    B[c1][c2]<=b;
                end
                else if(M<=c1<N)
                A[c1][c2] <= a;
            end
        s1:
            begin
                c2<=c2+1;
            end
        s2:
            begin
                c2<=0;
                c1<=c1+1;
            end
            
        s3: 
            begin
            if(c5<M)
            begin
                if(c6<M)
                    begin
                    if(c3 < N - M + 1) begin 
                      if (c4 < N - M + 1) begin   
                        temp1 <= A[c3+c5][c4+c6];
                        temp2 <= B[c5][c6];
                      end
                     end
                  end
            end
            end
        s4:  begin
           p <= t2;
            end
        s9 : begin
            t1 <= y;
            c6 = c6+1;
             end 
        s5: 
            begin
                c6<=0;
                c5<=c5+1;
            end
        s6: 
            begin
             
                out<=t1;
                t1 <=0;
                p <=0;
                c5<=0;
                c6<=0;
                sum<=0;
                c4<=c4+1;
            end
        s7: 
            begin
                c4<=0;
                c3<=c3+1;
            end    
        s8: 
            done<=1;
        
        endcase
      end
      
   always@(*) 
    begin
        case(ps)
        init: ns=s0;
        s0: begin
            if (c1 < N) 
                begin
                    if(c2<N)
                        ns = s1;
                    else
                        ns = s2;
                end 
            else 
                ns = s3;
            end
        s1: 
            ns=s0;
        s2: 
            ns=s0;
        s3: begin
            if(c3<N-M+1)
            begin
                if(c4<N-M+1)
                begin
                    if (c5<M) 
                        begin
                            if(c6<M)
                                ns = s4;
                            else
                                ns = s5;
                        end 
                    else 
                        ns = s6;
                end
                else 
                    ns=s7;
                end
            else
                ns=s8;
            end
        s4: 
            ns=s9;
       s9 :
            ns = s3;
        s5: 
            ns=s3;
        s6: 
            ns=s3;
        s7: 
            ns=s3;
        s8: 
            ns=s8;
        endcase
    end
endmodule

