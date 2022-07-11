ORG 100h
.MODEL SMALL 
.DATA
NUM_1 DD 3AB45Eh
NUM_2 DW 0A1h
.CODE   
MOV BX, NUM_2     ;Load numerator in BX 
MOV AX, [NUM_1+0]     ;Load denominator in AX    
MOV DX, [NUM_1+2]
DIV BX            ;Divide BX by DX:AX
RET