DSEG SEGMENT
tbao1 DB "Good morning.$"
tbao2 DB "Good Afternoon.$"  
tbao3 DB "Good Evening!$" 
DSEG ENDS
CSEG SEGMENT
ASSUME CS: CSEG, DS: DSEG
start:
mov ax, DSEG
mov ds, ax  

mov ah, 01h 
int 21h 

cmp al,'S'
je morning

           
cmp al, 's'
je morning

        
cmp al,'T'
je evening 

           
cmp al, 't'
je evening

cmp al,'C'
je afternoon
  
cmp al, 'c'
je afternoon
jmp exit      
morning: 
mov ah, 09 
lea dx, tbao1
int 21h   
mov ah, 4ch
int 21h

afternoon:
mov ah, 09
lea dx, tbao2
int 21h
mov ah,4ch
int 21h

evening:
mov ah, 09
lea dx, tbao3
int 21h
mov ah,4ch
int 21h

exit:
mov ah, 4Ch 
int 21h
CSEG ENDS
END start
