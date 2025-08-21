// Revision 0.01 - File Created
module test();
reg clk, rst;
    reg [31:0] a, b;
    wire [31:0] out;
    wire done;
    
    // Instantiate the convolution module
   IEEE #(3,2) a1(clk,rst,a,b,out,done);
    
  
    always #5 clk = ~clk; 
    
    initial begin
    
        clk = 0;
        rst = 1;
        #100;
        
        
        
        rst = 0; 
        
        #3 a = 32'h3F99999A; b=32'h3F000000;
        #20 a = 32'hC0200000; b = 32'hBFF19999;
        #20 a = 32'h4059999A;
        #40 a=32'hBF4CCCCD; b = 32'hBF666666;
        #20 a = 32'h40066666;b = 32'h40133333;
        #20 a = 32'hC0733333; 
        #40 a=32'h3F19999A; 
        #20 a=32'hBFA66666; 
        #20 a=32'h40366666;
      
     end 
       
endmodule
