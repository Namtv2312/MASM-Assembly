; Chuong trinh dem tu trong file, input file path, output number word 
; luong chuong trinh:
;nhap file path, 09/21h, end file with 0dh, need replace it with 0 (file handle requied it)
; đọc từng ký tự trong file, add vào buff, bao giờ đến End of file(EOF) thì đóng file, và  đến bước xử lý đếm từ trong bufff,
;nếu không đọc được file( file path sai thì nhảy đến label xử lý, xem muốn nhập file path nữa không)
; 

.model small
.stack 10000
.data    
        file_handle dw ?
        input_msg db 10,13,"Input File Path: ",10,13,'$'
        filename db 100 dup('$')
          
        outputt db 13,10,"Number words in File: ",'$'
        err_msg db 13,10,"File handle err, open again",10,13,'$'
        options db 13,10,"Yes (y), No (n): ","$"
         buff db 10000 dup ("$")

.code

main proc   
    mov ax, @data
    mov ds, ax
    
inp_filename:
       lea dx, input_msg 
       mov ah, 9h
       int 21h

       mov dx, offset filename
       mov ah, 0ah
       int 21h
       

       xor bx,bx
       mov bl, [filename+1]         
       mov [filename+2+bx],0                           ; replace end input string file path with 0
                     

            mov ah, 3dh
            mov al,2
            mov dx, offset filename +2                  ; file path start at filename+2, read document at 0ah/21h
            int 21h
            jc errr                                      ; iff err cary flag set, jump handle err
           mov di, offset file_handle
           mov [di], ax                                     ; cất file handle vào biến file_handle
           xor si,si
 handle_str:
           mov ah,3fh
           lea dx, buff +si                                 ;read 1 byte từ file cất vào (buff+ chỉ số trong si tăng dần) , cho tới EOF
           mov cx,1
           mov bx, file_handle                              
           int 21h
           jc errr                                           ; lỗi read thì đến label xử lý lỗi
           cmp ax,cx
           jnz EOF                                            ;ax chứa real number byte read, not equal cx ( số byte mong muốn đọc), ngầm hiểu là Endfile. thì nhảy tới label xử lý eof
           inc si
           jmp handle_str
       
EOF:                                                                            ;endfile thì đóng file và đi tới bước xử lý đếm từ
         mov bx, file_handle
         mov ah,3eh
         int 21h
         jmp output       
errr:                                              ; vòng lặp nhập lại(y/n) nếu file path sai hoặc không đọc được file, các lỗi liên quan xử lý file
         lea dx, err_msg
         mov ah, 9
         int 21h

         lea dx, options
         mov ah,9
         int 21h

         mov ah,1
         int 21h
         cmp al,'y'
         jz inp_filename
         cmp al,'n'
         jz exit
         cmp al,'N'
         jz exit
         jmp  inp_filename
 output:                                      ; bắt đầu đếm từ trong buff, lấy từ trong file

        xor si,si
        xor cx,cx
        mov bx, offset buff

chk:                                           ; tìm từ trong buff ( tức trong khoảng [A,Z]  [a,z])
      cmp  byte ptr[bx+si], 'A'                         
      jnae fails                                 ; chưa tìm được  thì tăng chỉ số và lặp lại bước tìm này
      cmp byte ptr [bx+si], 'Z'
      jbe inc_count                           ; tìm được thì tăng bộ đếm và đi đến tìm non-alphabet
      cmp byte ptr [bx+si], 'a'                                  
      jnae fails  
      cmp byte ptr[bx+si], 'z'
      jbe inc_count
     
fails:                                         ; tăng chỉ số và lặp lại bước tìm từ, so sánh xem đã end buff chưa, end rồi thì in kết quả
       inc si
       cmp byte ptr [bx+si],  '$'
       jz results
       jmp chk  
       
do_str:                                            ; sau khi tìm được 1 alphabet đầu tiên ta sẽ đi tìm kiếm các non-alphabet, khoảng cách giữa 1 alphabet, và 1 non-alphabet là 1 từ, 
      cmp  byte ptr [bx+si], 'A'                  ; lặp tới khi end buff
      jnae chk    
      cmp byte ptr[bx+si], 'Z'
      jbe fails_sp                   
      cmp byte ptr[bx+si], 'a'
      jnae chk  
      cmp byte ptr[bx+si], 'z'
      jbe fails_sp
fails_sp:                                                   
       inc si
       cmp byte ptr[bx+si],  "$"
       jz results
       jmp do_str  
      
inc_count:                            
   inc si
   inc cx                                    ; tăng bộ đếm
    cmp byte ptr[bx+si],  "$"                       
    jz results
    jmp do_str
        
results:                                                             ; in kết quả
     mov dx, offset outputt
     mov ah,09h
     int 21h

    mov ax, cx                                                      ; move number count word cx vào ax để xử lý chia 10 lấy dư , đẩy vào stack và pop ra in từng số dư là được kết quả
    mov bx,10
    xor cx,cx                           
    _loop:
            xor dx,dx
            div bx                                             ;dx:ax chia cho 10
            push dx                                             ; dư trong dx, ax chứa thương
            inc cx
            cmp ax,0                       
            jz hienthi
            jmp _loop
    hienthi: 
            pop dx 
            add dx,30h
            mov ah,2
            int 21h
            loop hienthi           


exit:
     mov ah, 4ch
     int 21h 
        
main endp
end main