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
    msv1 db "at160632"
    msv2 db "AT160632" 
    str 30,?,30 dup("$")  ,"nam4lpha" 
    xdong db 10,13,"$" 
    msg4 db 10,13,"So luong SNT trong chuoi la: $"
    chuoi db 0,1,2,3,4,5,6,7,8,9
    dem dw 0
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
    
      
dem_snt:
    inchuoi msg4
    mov cx,10 ;so phan tu cua chuoi so co san trong data
    lea si,chuoi
    lap:     
        mov bx,2
        xor ah,ah  
        mov al,[si]
        cmp al,2
        jb  khongPhaiSNT
        jz SNT
    lap2:
        mov al,[si]
        xor dx,dx
        div bx
        cmp dx,0
        jz khongPhaiSNT
        inc bx
        mov al,[si]
        cmp bx,ax
        jb lap2 
    SNT:
        add dem,1   
    khongPhaiSNT:
        inc si
        loop lap 
;in so luong SNT ra man hinh
    mov bx,10 
    mov ax,dem 
    xor cx, cx
    _push:   
        xor dx,dx
        div bx 
        push dx
        inc cx
        cmp ax,0
        jz hienthi
        jmp _push

    hienthi:
        pop dx
        add dx,30h
        mov ah,2
        int 21h
        loop hienthi      
      
thoat: 
    mov ah,4ch
    int 21h
    main endp
end main