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
       
       
       
    filename db 30 dup(0)
    msg4 db 10,13,"Nhap ten file: $"
    msg5 db 10,13,"Nhap noi dung file: $" 
    msg6 db 10,13,"Nhap thanh cong$"
    str1 db 100,?,100 dup("$")
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
    
;create new file
    inchuoi msg4
    mov si,0
nhap_filename:
    mov ah,1
    int 21h
    cmp al,0Dh
    je taofile
    mov filename[si],al
    inc si
    jmp nhap_filename
taofile:
    mov ah,3ch
    lea dx,filename
    mov cx,0 ;thuoc tinh cua file
    int 21h  ;ax = file handle (tep xu li) 
nhap_ndfile:
    mov pf,ax ;cat file, gan con tro file cho buffer 
    inchuoi msg5  
    mov ah,0Ah
    lea dx,str1 
    int 21h
    mov ah,40h
    mov bx,pf ;truyen file handle vao trong bx, gan con tro
    xor cx,cx
    mov cl,[str1+1]  ;so byte de viet 
    lea dx,str1+2   ;du lieu de viet vao file
    int 21h 
    mov ah,3eh
    mov bx,pf
    int 21h  
    inchuoi msg6      

thoat: 
    mov ah,4ch
    int 21h
    main endp
end main