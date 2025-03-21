module PC( clk, rst, NPC, PC );
  input              clk;
  input              rst;
  input       [31:0] NPC;
  output reg  [31:0] PC;

  always @(posedge clk, posedge rst) begin
    if (rst) begin
       PC <= 32'h0000_0000;
       //$write("\n reset pc = %h: ", PC);
       end
    else 
       begin 
         PC <= NPC; 
         //$write("\n pc = %h: ", PC);
       end
  end
  
endmodule

