.model small 
inchuoi macro chuoi 
    mov ah,9
    lea dx,chuoi
    int 21h
endm
.stack 100h
.data

       
    filename db 30 dup(0)
    output1 db 10,13,"Nhap ten file: $"
    output2 db 10,13,"Nhap noi dung file: $" 
    output3 db 10,13,"Nhap thanh cong$"
    str1 db 100,?,100 dup("$")
    pf dw ?   
.code
main proc 
    mov ax,@data
    mov ds,ax 

;create new file
    inchuoi output1
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
    inchuoi output2  
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
    inchuoi output3      

thoat: 
    mov ah,4ch
    int 21h
    main endp
end main