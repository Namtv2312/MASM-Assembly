CSEG SEGMENT
ASSUME CS: CSEG
start: 
mov ah, 08h 
int 21h 
mov bl, al
nhan: mov ah, 02h 
mov dl, bl ; 
int 21h
mov dl, ' '
int 21h  
inc bl 
cmp bl, 'z'
jbe nhan 
mov ah, 08h 
int 21h
mov ah, 4Ch
int 21h
CSEG ENDS
END start