.model small 
inchuoi macro chuoi 
    mov ah,9
    lea dx,chuoi
    int 21h
endm
.stack 100h
.data
    msg1 db "Nhap vao ten SV: $"
    msg2 db 10,13,"Ma Sinh Vien la: AT160632$"
    msg3 db 10,13,"Thong tin sai!!!Nhap lai$" 
    xdong db 10,13,"$"  
    msv1 db "Tran Van Nam"
    str 30,?,30 dup("$")      

.code
main proc 
    mov ax,@data
    mov ds,ax 
    mov es,ax   
;nhap msv 
nhapmsv: 
    inchuoi msg1
    mov ah,0Ah
    lea dx,str
    int 21h
    xor cx,cx
         
kiemtra:    
    mov cl,12
    mov bl, [str+1]
    cmp cl, bl
    jnz nhaplai 
    lea si,str+2
    lea di,msv1
    repe cmpsb
    je intb1  
    
nhaplai:
    inchuoi msg3
    inchuoi xdong
    jmp nhapmsv
intb1:
    inchuoi msg2  
         
thoat: 
    mov ah,4ch
    int 21h
    main endp
end main