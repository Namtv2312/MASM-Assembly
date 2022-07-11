DSEG SEGMENT
tbao DB 'Hay go vao 1 phim: $'
DSEG ENDS
CSEG SEGMENT
ASSUME CS: CSEG, DS: DSEG
start:mov ax, DSEG
mov ds, ax
mov ah, 09h ; In câu thông báo ra màn hình
lea dx, tbao
int 21h
mov ah, 01h ; Ham 1, nhan ky tu tu ban phim
int 21h ; goi ngat thuc hien ham
mov ah, 4Ch ; tro ve he dieu hanh
int 21h
CSEG ENDS
END start