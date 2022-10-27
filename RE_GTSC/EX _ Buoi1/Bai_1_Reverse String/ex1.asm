.model small
.stack 100
.data
    strings db 100 dup("$")
    input db "Input a strings: $"
    output db 13, 10, "Reverse strings: $"
.code
    main proc
        mov ax, @data
        mov ds, ax                          ;init data segment 
        
        mov ah, 09h
        lea dx, input
        int 21h                             ; print chuỗi input

        mov bx, offset strings   
        xor si,si                           ;reset si=0 để lưu size String
        mov ah,1
        int 21h                             ;input ký tự đầu tiên, nếu không nhập, enter thì exit luôn
        cmp al, 0dh  
        jz exit   
        

 handle_str:                                ; label xử lý nhập chuỗi
        cmp al, 20h                         ; hàm 01/21h return trong al, so sánh ký tự đó trong khoảng PRINTABLE [0x20;0x7f]
        jnae in_str                         ; Nếu không thuộc khoảng đó thì nhập lại
        cmp al, 7fh
        jnbe in_str
        mov [bx+si],al                      ;nếu thuộc khoảng này thì gán vào Strings
        inc si                              ;nhập xong 1 ký tự chuẩn thì tăng size String lên 1
        
  in_str:                                   ;label input strings
  mov ah,1
  int 21h 
  cmp al, 0dh                               ;lặp lại bước nhập và xử lý character trên cho tới khi gặp  Enter (0dh)
  jne handle_str     
  
  
  
  ;reverse                                  ;thì tới giai đoạn đảo ngược chuỗi

    
        mov ah, 09h
        mov dx, offset output
        int 21h                             ; in chuỗi thông báo output
 
  cmp si, 100                               ; so sánh size String với 100 nếu nhỏ hơn hoặc bằng thì tới bước IN string
  jbe out_str                               
    mov si,100                              ; ngược lại, thì set si=100, theo y/c đề bài
   out_str:                                 ;label in chuỗi Reverse
   mov dl, [bx+si-1]                        ; in từ ký tự cuối chuỗi trở về, sau mỗi lần, giảm SI
   dec si
  mov ah,02h
  int 21h
  cmp si,0                                  
  jnz out_str  

    main endp  
 exit:                                          ; return control to the operating system  
    mov ah, 4ch
    int 21h   
    
    end main     
    

    