.model small 
inchuoi macro chuoi 
    mov ah,9
    lea dx,chuoi
    int 21h
endm
.stack 100h
.data 
    y dw ?
    x dw ?
   
    xdong db 10,13,"$"  

    msg4 db 10,13,"Nhap n = $"
    msg5 db 10,13,"n! = $"   
    err db 10,13,"Vui long nhap so khong am $"
.code
main proc 
    mov ax,@data
    mov ds,ax 
    
    mov x,0
    mov y,0
    mov bx,10

;Nhap n 

    inchuoi msg4
input:    
    mov ah,1
    int 21h 
     
    cmp al,13
    je solve
    
    cmp al, 30h
    jb error 
    sub al,30h
    
    xor ah,ah
    mov y,ax
    mov ax,x
    mul bx
    add ax,y
    mov x,ax
    jmp input
solve:   
    mov ax,0
    xor cx,cx
    mov cx,x
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
    loop hienthi e
    

thoat: 
    mov ah,4ch
    int 21h
    main endp 
error:
    inchuoi  err
    jmp input
end main