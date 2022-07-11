ORG 100h
.MODEL SMALL 
.DATA
NUM_1 DW 1000
NUM_2 DW 100h
.CODE   
MOV BX, NUM_2     ;Load numerator in BX  
MOV AX, NUM_1     ;Load denominator in AX
DIV BX            ;Divide BX by AX
RET