.model small 
inchuoi macro chuoi 
    mov ah,9
    lea dx,chuoi
    int 21h
endm
.stack 100h
.data
    xdong db 10,13,"$"  
  
    output1 db 10,13,"Nhap chuoi: $"
    output2 db 10,13,"So ky tu trong chuoi: $"
    str db 100,?,100 dup ("$") 
    count db 0
.code
main proc 
    mov ax,@data
    mov ds,ax 
    mov es,ax   

     
nhap_chuoi:   

    inchuoi output1 
    lea si,str
    xor cx,cx
    loop_input:
    
        mov ah,1
        int 21h
        mov [si],al
        inc si
        inc cx
        inc count        
        cmp al,0dh
        je endString
        jmp loop_input
    endString:        
    
        inchuoi output2         
        mov bx,10
        xor ax,ax
        mov al,count
        sub al,1
        xor cx,cx      
        
    lapchia:
        mov dx,0
        div bx
        inc cx
        push dx
        cmp al,0
        je show
        jmp lapchia
    show: 
        pop dx
        add dl,30h
        mov ah,2
        int 21h
        dec cx
        cmp cx,0
        jne show 
        jmp thoat        

thoat: 
    mov ah,4ch
    int 21h
    main endp
end main