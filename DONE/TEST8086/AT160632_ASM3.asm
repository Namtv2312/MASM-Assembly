.model small 
inchuoi macro chuoi 
    mov ah,9
    lea dx,chuoi
    int 21h
endm
.stack 100h
.data
    
    filename db "teptin.txt",0
    output3 db 10,13,"thanh cong$"
    str1 db "Tran Van Nam- AT160632$"
    pf dw ?   
.code
main proc 
    mov ax,@data
    mov ds,ax 

taofile:
    mov ah,3ch
    lea dx,filename
    mov cx,0 ;thuoc tinh cua file
    int 21h  ;ax = file handle (tep xu li) 
nhap_ndfile:
    mov pf,ax ;cat file, gan con tro file cho buffer 
    mov ah,40h
    mov bx,pf ;truyen file handle vao trong bx, gan con tro
    xor cx,cx
    mov cl,[str1+1]  ;so byte de viet 
    lea dx,str1   ;du lieu de viet vao file
    int 21h 
    mov ah,3eh
    mov bx,pf
    int 21h  
    inchuoi output3      

thoat: 
    mov ah,4ch
    int 21h
    main endp
end main