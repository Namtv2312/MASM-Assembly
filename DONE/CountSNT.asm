    .model small 
inchuoi macro chuoi 
    mov ah,9
    lea dx,chuoi
    int 21h
endm
.stack 100h
.data

    xdong db 10,13,"$" 
    output db 10,13,"So luong SNT trong chuoi la: $"
    chuoi db 0,1,2,3,4,5,6,7,8,9
    dem dw 0
.code
main proc 
    mov ax,@data
    mov ds,ax 
    mov es,ax   

      
count_snt:
    inchuoi output
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