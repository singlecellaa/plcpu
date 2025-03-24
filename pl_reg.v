module pl_reg #(parameter WIDTH = 32)(
    input clk, rst, 
    input [WIDTH-1:0] in,
    input Wr,
    output reg [WIDTH-1:0] out
    );
    
    always@(posedge clk, posedge rst)
      begin
          if(rst)
              out <= 0;
          else 
            if(Wr)
                begin
                    out <= in;
                end
      end
    
endmodule
