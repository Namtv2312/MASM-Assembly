.model small 
inchuoi macro chuoi 
    mov ah,9
    lea dx,chuoi
    int 21h
endm
.stack 100h
.data
    chuoi db 127,0,-4,-126,89,73,-34,-111,11
    output1 db 10,13,"So luong so nguyen duong: $"
    output2 db 10,13,"So luong so nguyen am: $"
    x dw 0
    y dw 0
.code
main proc 
    mov ax,@data
    mov ds,ax 
    mov es,ax   
    
    xor cx,cx
    mov cl,9 ;    Number of element    
    lea si,chuoi 
    
    
    solve:        
        cmp [si],0 
        jl soam 
        jg soduong
        jz so0
    soduong: 
        add x,1
        jmp so0 
    soam: 
        add y,1
        jmp so0            
    so0:
        inc si
        loop solve     
;in so luong so duong  


        inchuoi output1
        xor ax,ax
        mov ax,x
        call show  
        
    
;in so luong so am
        inchuoi output2
        xor ax,ax
        mov ax,y
        call show  

thoat: 
    mov ah,4ch
    int 21h
    main endp   

show proc
        mov bx,10
        xor cx,cx
        _loop:
            xor dx,dx
            div bx
            push dx
            inc cx
            cmp ax,0
            jz hienthi
            jmp _loop
        hienthi: 
            pop dx
            add dx,30h
            mov ah,2
            int 21h
            loop hienthi
    ret    
    show endp 


end main