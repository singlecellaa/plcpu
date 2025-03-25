# Test the RISC-V processor in simulation
# 待验证：lui, addi, add，sub，xor, or, and, srl, sra, sll, sw, lw
# 本测试只验证单条指令的功能，不考察转发和冒险检测的功能，所以在相关指令之间添加了足够多的nop指令

#		Assembly	     		Description
main:	lui x5, 0x12345              #x5 <== 0x12345
		lui x6, 0xfffff              #x6 <== 0xfffff
		addi	x12, x0, 4           #x12 <== 0x00000004
		addi	x0, x0, 0            #nop
		addi	x0, x0, 0
        add	x7, x5, x6               #x7 <== 0x12344000
        
        sub	x8, x5, x6               #x8 <== 0x12346000

        xor	x9, x5, x6               #x9 <== 0xEDCBA000
        or	x10, x5, x6              #x10 <== 0xFFFFF000
        and	x11, x5, x6 	         #x11 <== 0x12345000

        srl	x13, x6, x12	         #x13 <== 0x0FFFFF00
        sra	x14, x6, x12	         #x14 <== 0xFFFFFF00
        sll	x15, x5, x12	         #x15 <== 0x23450000

        addi    x10, x10, 0x123      #x10 <== 0xFFFFF123
        sw x10, 0(x12)               #mem[4] <== 0xFFFFF123
        sw x11, 4(x12)               #mem[8] <== 0x12345000
        lw x16, 0(x12)               #x16 <== 0xFFFFF123
        lw x17, 4(x12)               #x17 <== 0x12345000
        addi x17, x17, 0x123         #x17 <== 0x12345123
		addi	x0, x0, 0            #nop
		addi	x0, x0, 0        
		addi	x0, x0, 0
        add     x18, x16, x17        #x18 <== 0x12344246, 0xFFFFF123+0x12345123
        add     x19, x18, x18        #x19 <== 0x2458848c
        add     x20, x18, x18        #x20 <== 0x2458848c
        slt     x21, x7, x5          #x21 <== 0x1,  0x12344 < 0x12345
        sltu    x22, x5, x6          #x21 <== 0x1,  0x12345 < 0xffff0
        andi    x22, x22,0x0         #x22 <== 0x0,  0x1 & 0x0
        ori     x22, x22,0x3         #x22 <== 0x3,  0x3 | 0x0
        xori    x22, x22,0x1         #x22 <== 0x2,  0x3 ^ 0x1
        srli    x23, x6, 0x4         #x23 <== 0x0FFFFF00
        srai    x24, x6, 0x4         #x24 <== 0xFFFFFF00
        slli    x25, x5, 0x4         #x25 <== 0x23450000
        slti    x26, x6,0x7FF        #x26 <== 0x1, 0x2 < 0x123
        sltiu   x26, x6,0x7FF        #x26 <== 0x0, 0x2 < 0x7FF  
label1: lui     x5, 0x1              #x5 <== 0x1
        beq x19, x20, label2         #taken
	jal x0, label1
label2: lui     x5, 0x2
        bne     x25, x26, label3     #0x2345 != 0x0
        jal x0, label2
label3: lui     x5, 0x3
        bge     x23,x24, label4
        jal x0, label3
label4: lui     x5, 0x4
        bgeu    x24,x23, label5
        jal x0, label4
label5: lui     x5, 0x5
        blt     x24,x23, label6
        jal x0, label5
label6: lui     x5, 0x6
        bltu    x23,x24, label7
        jal x0, label6
label7: lui     x5, 0x7
        jal x26,label8 
        jal x0, label7            
        addi    x0, x0, 0
label8: lui     x5, 0x8
        jalr x0, x26, 0
        jal x0, label1
