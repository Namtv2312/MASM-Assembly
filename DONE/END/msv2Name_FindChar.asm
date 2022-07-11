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
        msg4 db 10,13,"Nhap chuoi: $"
    msg5 db 10,13,"Nhap ky tu kiem tra: $"
    msg6 db 10,13,"Ky tu co ton tai trong chuoi!$"
    msg7 db 10,13,"Ky tu khong ton tai trong chuoi!$"
    msg8 db 10,13,"So luong ky tu trong chuoi: $"   
    str2 db 100,?,100 dup('$')
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
    
;nhap chuoi
    inchuoi msg4
    mov ah,0Ah 
    lea dx,str2 
    int 21h
    xor cx,cx
    mov cl,[str2+1] 
;nhap kytu muon ktra
    inchuoi msg5
    mov ah,1
    int 21h    
    xor di,di ;luu so lan xuat hien 
    lea si,str2+2 
ktr_kytu:
    mov bl,[si]
    cmp bl,al
    je tontai
    inc si    
    loop ktr_kytu
    cmp di,0
    je khongtontai
    jmp hienthi
khongtontai:
    inchuoi msg7
    jmp thoat
tontai:
    inc si 
    inc di    
    loop ktr_kytu     
hienthi:
    inchuoi msg6
    inchuoi msg8
    mov ax,di 
    xor cx,cx
    mov bx,10
    lap_push:
        xor dx,dx
        div bx
        push dx
        inc cx
        cmp ax,0
        jz ht
        jmp lap_push
   ht:
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