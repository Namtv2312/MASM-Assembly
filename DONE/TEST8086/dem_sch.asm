.data
    tb db 'So cac so chia het cho so da cho trong day la: $'
    tb1 db 'So bi chia khong duoc la so 0$'
    arr db -5,6,0,15,25,35,45,65,75,85,95,55
    sochia db -5
    n db 12
    so db 0
    
.code
main proc
    mov ax, @data
    mov ds, ax
     
    
    mov bl, sochia    
    cmp bl, 0
    jl chuyen
    je sokhong
    jmp next
    
    sokhong:
        mov ah, 9
        lea dx, tb1
        int 21h
        jmp thoat
    
    
    chuyen:
        mov dl, 0
        sub dl, bl
        mov bl, dl
        mov sochia, bl
    
    next:
        mov ah, 9
        lea dx, tb
        int 21h
        
        lea si, arr
        mov cl, n 
    
    duyet:
        mov ax, 0
        mov al, [si]
        
        cmp al, 0
        jl soam
        jmp kiemtra
        
    soam:
        mov dl, 0
        sub dl, al
        mov al, dl 
        
    kiemtra:
        div sochia
        
        cmp ah, 0
        je tinhtong
        
        jmp tiep
        
        tinhtong:
            mov al, so
            inc al
            mov so, al
            
        tiep:
            inc si
            loop duyet
            
     mov al, so
     mov bl, 10
     mov cx, 0
     
     todec:
        mov ah, 0
        mov dx, 0
        div bl
        inc cx
        
        mov dl, ah
        add dl, 30h
        push dx
        
        cmp al, 0
        je hienthi
        
        jmp todec
     hienthi:
        pop dx
        mov ah, 2
        int 21h
        loop hienthi
     thoat:   
         mov ah, 8
         int 21h
         
         mov ah, 4ch
         int 21h
     
     main endp
end main

