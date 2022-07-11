.model small 
inchuoi macro chuoi 
    mov ah,9
    lea dx,chuoi
    int 21h
endm
.stack 100h
.data
    msg1 db "Nhap ma SV: $"
    msg2 db 10,13,"Name: Tran Van Nam$"
    msg3 db 10,13,"Thong tin sai!!!Nhap lai$" 
    xdong db 10,13,"$"  
    msv1 db "at160632"
    msv2 db "AT160632" 
    str 30,?,30 dup("$")  ,"nam4lpha" 
    msg4 db 10,13,"Nhap n = $"
    msg5 db 10,13,"n! = $" 
.code
main proc 
    mov ax,@data
    mov ds,ax 
    mov es,ax   
;nhap msv 
nhapmsv: 
    inchuoi msg1
;nhap chuoi
    mov ah,0Ah
    lea dx,str
    int 21h
    xor cx,cx
         
kiemtra:    
    mov cl,8
    mov bl, [str+1]
    cmp cl, bl
    jnz nhaplai 
    lea si,str+2
    lea di,msv1
    repe cmpsb
    je intb1  
    lea si,str+2
    lea di,msv2
    repe cmpsb
    je intb1
nhaplai:
    inchuoi msg3
    inchuoi xdong
    jmp nhapmsv
intb1:
    inchuoi msg2  
    
;Nhap n
    inchuoi msg4
    mov ah,1
    int 21h
    sub al,30h
    xor cx,cx
    mov cl,al
    inchuoi msg5    
    mov ax,1
    mov bx,1
giaithua: 
    mul bx
    inc bx
    cmp bx,cx
    jle giaithua
xor cx,cx 
mov bx,10
lappush:
    xor dx,dx
    div bx
    add dx,30h
    push dx
    inc cx
    cmp ax,0
    jne lappush
hienthi: 
    pop dx
    mov ah,2
    int 21h
    loop hienthi
thoat: 
    mov ah,4ch
    int 21h
    main endp
end main