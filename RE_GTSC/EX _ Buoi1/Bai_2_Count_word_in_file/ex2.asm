.model small
.stack 100
.data 
filename db 100 dup('$')
file_handle dw ?    
buff db 100 dup ("$")
file_size dw ?  
output db 13,10,"Number words in File: ",'$'
.code

main proc   
    mov ax, @data
    mov ds, ax
    
       mov dx, offset filename
       mov ah, 0ah                              ;nhập file name
      
       int 21h
       
       
       ;replace odh with 0                      ; thay thế ký tự enter bằng null, cho đúng yêu cầu ASCIZ tên file
        xor bx,bx
       mov bl, [filename+1]         
       mov [filename+2+bx],0


mov ah,02
mov dl,13
int 21h
mov ah,02
mov dl,10
int 21h                                          ;in LineFeed, carry return


mov ah, 3dh
mov al,2
mov dx, offset filename +2                        ; Hàm 3dh/21h, sau khi dùng hàm nhập 0ah/21h , String bắt đầu ở buffer+2
int 21h
              
       mov di, offset file_handle                  ;lưu file handle nhận được sau khi kết thúc 3dh/21h vào biến file_handle
       mov [di], ax
       
     mov ah, 3fh
     mov di, offset file_handle                     ;đọc file lưu vào mảng buff
     mov bx,[di]
     mov cx, 4000
     mov dx, offset buff
     int 21h
     
     mov di, offset    file_size
     mov [di],ax                                    ;lưu số ký tự thực đọc được sau khi kết thúc 3fh/21h vào biến file_size
     xor si, si  
       xor cx, cx                                       ;reset các thanh ghi cần thiết cho giai đoạn xử lý tiếp theo cx, count word, si cho index
      mov bx, offset buff                              ;bx chứa địa chỉ của buff
   ;  mov cx,ax  
    ;output:
     ;mov ah,2
     ;mov dl, [bx]
     ;int 21h
     ;inc bx
     ;dec cx
     ;jnz output   
     
                  
  chk:                                                  ;label xử lý tìm ký tự alphabet
      cmp  [bx+si], 41h                                 ; so sánh ký tự nằm trong khoảng [A-Z]; và trong khoảng [a-z]
      jnae fails                                        ; vẫn chưa phải thì tăng chỉ số và tìm tiếp, cho tới khi gặp terminate Strings('$', hex=24h)
      cmp [bx+si], 5ah
      jbe inc_count                     ; tìm được 1 ký tự alphabet đầu tiên thì đi tới bước tìm hết các ký tự liền kề, cho tới khi gặp non-alphabet
      cmp [bx+si], 61h                                  
      jnae fails  
      cmp [bx+si], 7ah
      jbe inc_count
     
      fails:                            ;label check ký tự tiếp theo
       inc si
       cmp [bx+si],  24h
       jz results
       jmp chk  
       
     do_str:                            ;label check IsAlpha
      cmp  [bx+si], 41h                 ;không thuộc khoảng [A-Z],[a-z] thì jmp về chk để tìm tiếp
      jnae chk    
      cmp [bx+si], 5ah
      jbe fails_sp                      ;là ký tự thì check tiếp ký tự liền kề cho tới khi gặp non-alphabet
      cmp [bx+si], 61h
      jnae chk  
      cmp [bx+si], 7ah
      jbe fails_sp
     fails_sp:
       inc si
       cmp [bx+si],  24h
       jz results
       jmp do_str  
      
   inc_count:                               ; khoảng cách sau mỗi lần tìm được 1 alphabet và 1 non-alphabet là 1 từ, 
   inc si
   inc cx
    cmp [bx+si],  24h                       ; tìm cho tới khi kết thúc chuỗi
    jz results
   jmp do_str
        
results:                                    ; In thông báo kết quả
         mov dx, offset output
         mov ah,09h
         int 21h


mov ax, cx                                  ; set ax với cx (chứa số từ trong file)
        mov bx,10
        xor cx,cx                           
        _loop:
            xor dx,dx
            div bx                          ;dx:ax chia cho 10 số dư trong dx
            push dx                         ; đẩy phần dư vào stack
            inc cx
            cmp ax,0                        ; cho tới khi phần nguyên =0, thì hiển thị
            jz hienthi
            jmp _loop
        hienthi: 
            pop dx                          ; pop dần dx ra, tăng 30h thành character, và in
            add dx,30h
            mov ah,2
            int 21h
            loop hienthi
     
    
    main endp  
 exit:
    mov ah, 4ch
    int 21h   
    
    end main     