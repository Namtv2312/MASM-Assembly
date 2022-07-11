ORG 100h
.MODEL SMALL 
.DATA
NUM_1 DW 1000
NUM_2 DB 100
.CODE   
MOV BH, NUM_2     ;Load numerator in BH  
MOV AX, NUM_1     ;Load denominator in AX
DIV BH            ;Divide BH by AX
RET