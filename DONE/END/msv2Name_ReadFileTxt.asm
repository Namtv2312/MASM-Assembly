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
     
     
        msg4 db 10,13,"Nhap ten file: $"
    msg5 db 10,13,"noi dung file la: $" 
    noidung db 100 dup("$")
    ten db 30 dup(0)
    pf dw ? 
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
    
;nhap ten file
    mov ah,9
    lea dx,msg4
    int 21h 
    mov si,0
nhap_filename:
    mov ah,1
    int 21h
    cmp al,0Dh
    je read
    mov ten[si],al
    inc si
    jmp nhap_filename
read: 
    mov ah,9
    lea dx,msg5
    int 21h 
;open file 
    mov ah,3Dh
    mov al,2
    lea dx, ten
    int 21h
    mov pf,ax 
;read file
    mov ah,3Fh
    mov bx,pf
    mov cx,250
    lea dx,noidung    
    int 21h
;close file
    mov ah,3Eh
    mov bx,pf
    int 21h 
    mov ah,9
    lea dx,noidung
    int 21h  


thoat: 
    mov ah,4ch
    int 21h
    main endp
end main