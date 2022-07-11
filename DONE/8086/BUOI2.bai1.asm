CSEG SEGMENT
ASSUME CS: CSEG
start: mov ah, 02h ; Hàm 2, in 1 ký t? ra màn hình
mov dl, 'B' ; DL ch?a ký t? c?n in
int 21h ; g?i ng?t d? th?c hi?n hàm
mov ah, 08h ; Hàm 08h, ng?t 21h
int 21h
mov ah, 4Ch ; Thoát kh?i chuong trình
int 21h
CSEG ENDS
END start
