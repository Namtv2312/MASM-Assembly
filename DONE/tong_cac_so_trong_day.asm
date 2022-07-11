.data
 Enter DB 0Dh, 0Ah, '$'   
 m db 6,2,-9,-12,-10,33
 n dw 6
 str db "Tong cac so nguyen to trong day la: $"
 num db ?
 du db ?
 tong db 0
.code
    main proc
        mov ax,@data
        mov ds,ax
        lea dx, str
        mov ah,9
        int 21h
        lea si,m  
        mov cx, n
           
        duyet:
            mov al,[si] 
            mov num, al
            mov ah, 0

            mov al, num
            mov bl, tong
            add al, bl
            mov tong, al
             
        tiep:
            inc si 
            loop duyet 
        
        cmp tong, 0
        jl soam
        jmp ketqua
        
        soam:
            mov dl,45
            mov ah, 2
            int 21h 
            
            mov al, 255
            sub al, tong
            inc al      
            mov tong, al
        
        ketqua:
            mov al,tong 
            mov bl,10
            mov cx,0 
        todec:
            mov ah,0 
            div bl 
            mov dl,ah 
            add dl,30h 
            push dx 
            inc cx 
            cmp al,0 
            je inso
            jmp todec
        inso:
            pop dx
            mov ah,2
            int 21h
            loop inso
            
        mov ah,4ch
        int 21h
    main endp
end main