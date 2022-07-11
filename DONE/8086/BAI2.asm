DSEG SEGMENT
tbao1 DB "Ky tu HOA.$"
tbao2 DB "Ky tu thuong.$" 
tbao3 DB "Ky tu khac.$"
DSEG ENDS
CSEG SEGMENT
ASSUME CS: CSEG, DS: DSEG
start:
mov ax, DSEG  
mov ds, ax  


mov ah, 01h 
int 21h 

cmp al, 'a'
jae    thuong   
cmp al,'A'
jae hoa 
jmp khac  



thuong:    
cmp al, 'z'
jbe       printthuong
jmp khac   

printthuong:
mov ah, 09
lea dx, tbao2
int 21h 
jmp exit
   
hoa:   
cmp al, 'Z'
jbe       printhoa
jmp khac    

printhoa:
mov ah, 09
lea dx, tbao1
int 21h 
jmp exit

khac:
mov ah, 9
lea dx, tbao3
int 21h    
exit:
mov ah, 4Ch 
int 21h
CSEG ENDS
END start
