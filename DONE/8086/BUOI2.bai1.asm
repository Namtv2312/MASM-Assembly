CSEG SEGMENT
ASSUME CS: CSEG
start: mov ah, 02h ; H�m 2, in 1 k� t? ra m�n h�nh
mov dl, 'B' ; DL ch?a k� t? c?n in
int 21h ; g?i ng?t d? th?c hi?n h�m
mov ah, 08h ; H�m 08h, ng?t 21h
int 21h
mov ah, 4Ch ; Tho�t kh?i chuong tr�nh
int 21h
CSEG ENDS
END start
