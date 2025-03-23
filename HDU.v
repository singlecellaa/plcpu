module HDU (
    input  [4:0] ID_rs1,       
    input  [4:0] ID_rs2,       
    input  [4:0] EX_rs1,       
    input  [4:0] EX_rs2,       
    input  [4:0] EX_rd,         
    input  [4:0] MEM_rs2,  
    input  [4:0] MEM_rd,  
    input  [4:0] WB_rd, 
    
    input        EX_MemRead,   // EX阶段是否为Load指令
    input        EX_MemWrite,   
    input        MEM_MemWrite,
    input        MEM_RegWrite, 
    input        WB_RegWrite, 
    output       Stall,       
    output [1:0] BusAFw,      
    output [1:0] BusBFw,       
    output       DiSrc         
);

    assign BusAFw[1] = MEM_RegWrite && (MEM_rd != 0) && (MEM_rd == EX_rs1); 
    assign BusBFw[1] = MEM_RegWrite && (MEM_rd != 0) && (MEM_rd == EX_rs2); 
    assign BusAFw[0] = WB_RegWrite && (MEM_rd != 0) && (MEM_rd != EX_rs1) && (WB_rd == EX_rs1); 
    assign BusBFw[0] = WB_RegWrite && (MEM_rd != 0) && (MEM_rd != EX_rs2) && (WB_rd == EX_rs2); 
    assign DiSrc     = WB_RegWrite && (WB_rd != 0) && (WB_rd == MEM_rs2) && MEM_MemWrite; 
    assign Stall     = EX_MemRead   && ((EX_rd == ID_rs1) || (EX_rd == ID_rs2));

endmodule