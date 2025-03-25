`include "ctrl_encode_def.v"

module NPC(PC, EX_PC, NPCOp, IMM, ALUOut, NPC);  // next pc module
   input  [31:0] PC;        // pc
   input  [31:0] EX_PC;
   input  [4:0]  NPCOp;     // next pc operation
   input  [31:0] IMM;       // immediate
   input  [31:0] ALUOut;
   output reg [31:0] NPC;   // next pc
   
   wire [31:0] PCPLUS4;
   assign PCPLUS4 = PC + 4; // pc + 4
  
   always @(*) begin
        case (NPCOp)
          `NPC_PLUS4:  NPC = PCPLUS4;   // NPC computes addr
          `NPC_BRANCH: NPC = EX_PC+IMM;    //B type, NPC computes addr
          `NPC_JUMP:   NPC = EX_PC+IMM;    //J type, NPC computes addr
          `NPC_JALR:   NPC = ALUOut;
            default:     NPC = PCPLUS4;
        endcase
    end // end always
   
endmodule
