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
        msg4 db 10,13,"Nhap 1 so (he thap phan) : $"
    msg5 db 10,13,"Co so 16: $"
    msg6 db 10,13,"He nhi phan (16bit): $" 
    x dw 0
    y dw 0
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



;nhap so 
    inchuoi msg4     
    mov bx,10
    nhap: 
        mov ah,1
        int 21h
        cmp al,13  
        je he_nhiphan
        sub al,30h  
        xor ah,ah
        mov y,ax
        mov ax,x
        mul bx
        add ax,y
        mov x,ax 
        jmp nhap
    he_nhiphan:
        inchuoi msg6
        xor bx,bx
        mov bx,x
        mov cx,16
        hienthi_he2:
            mov dl,30h
            shl bx,1 ;day bit cao nhat cua bx vao co CF
            adc dl,0  ;dl = dl+0+CF
            mov ah,2
            int 21h
            loop hienthi_he2 
    hr_thapluc:
        inchuoi msg5
        mov ax,x
        xor cx,cx
        chuyen_he16:
            xor dx,dx
            mov bl,16
            div bx
            cmp dx,9
            ja chucai
            add dx,30h
            jmp chuso
        chucai:
            add dx,37h ;dua ve chu
        chuso:
            push dx
            inc cx
            cmp ax,0
            jne chuyen_he16 
       hienthi_he16:
            pop dx
            mov ah,2
            int 21h
            loop hienthi_he16    

thoat: 
    mov ah,4ch
    int 21h
    main endp
end main