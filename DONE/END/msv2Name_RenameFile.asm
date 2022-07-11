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
     
     
     
        msg4 db 10,13, "Nhap ten file cu: $" 
    msg5 db 10,13,"Nhap ten file moi: $"
    msg6 db 10,13,"Doi thanh cong.$"    
    old_fname db 30 dup(?),0  ;ten file co san 
    new_fname db 30 dup(?),0  
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
    

    inchuoi msg4   
    mov si,0  
    ;nhap ten moi cho file
nhap_tencu:
    mov ah,1
    int 21h
    cmp al,13
    je intb2
    mov old_fname[si],al
    inc si
    jmp nhap_tencu 
intb2:
    mov si,0
    inchuoi msg5
nhap_tenmoi:
    mov ah,1
    int 21h
    cmp al,13
    je doiten
    mov new_fname[si],al
    inc si
    jmp nhap_tenmoi    
doiten:
    mov ah,56h
    lea dx,old_fname
    lea di,new_fname
    int 21h 
    inchuoi msg6     
      

thoat: 
    mov ah,4ch
    int 21h
    main endp
end main