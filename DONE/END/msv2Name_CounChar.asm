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
    msg5 db 10,13,"So ky tu trong chuoi: $"
    str2 db 100,?,100 dup ("$") 
    count db 0
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
    
; count     
nhap_chuoi:
    inchuoi msg4 
    lea si,str2
    xor cx,cx
    lap_nhap:
        mov ah,1
        int 21h
        mov [si],al
        inc si
        inc cx
        inc count        
        cmp al,0Dh
        je endString
        jmp lap_nhap
    endString:        
        inchuoi msg5         
        mov bx,10
        xor ax,ax
        mov al,count
        sub al,1
        xor cx,cx
    lapchia:
        mov dx,0
        div bx
        inc cx
        push dx
        cmp al,0
        je ht
        jmp lapchia
    ht: 
        pop dx
        add dl,30h
        mov ah,2
        int 21h
        dec cx
        cmp cx,0
        jne ht 
        jmp thoat        

thoat: 
    mov ah,4ch
    int 21h
    main endp
end main