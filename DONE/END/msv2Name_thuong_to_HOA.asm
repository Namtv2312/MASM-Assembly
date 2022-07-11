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
    msg5 db 10,13,"Sau khi doi: $"
    str1 db 100,?,100 dup("$")    
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
    lea dx,str1
    int 21h    
    lea si,str1
    add si,2    
    kiemtra1: 
        mov al,[si]
        cmp al,0Dh ;Enter thi dung
        je hienthi
        cmp al,'Z'
        ja thuong_hoa
        inc si
        jmp kiemtra1        
    thuong_hoa:
        cmp al, 20h
        jz except
        sub al,20h ;dua chu hoa ve chu thuonh
    except:
        mov [si],al
        inc si 
        jmp kiemtra1
    hienthi:
        inchuoi msg5
        inchuoi str1+2
thoat: 
    mov ah,4ch
    int 21h
    main endp
end main       
                
                