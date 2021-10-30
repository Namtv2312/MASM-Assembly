include Irvine32.inc
.data
	bMinutes byte ?
	bSeconds byte ?
	bHours word ?
.code
main proc
	; get seconds
	mov al, dl
	and al, 00011111b
	mov bSeconds, al
	;get Minutes 
	mov ax, dx
	shr ax, 5
	and al, 00111111b
	mov bMinutes , al
	; get Hours
	mov al, dh			;chuyen doi thanh dh vao al
	shr al, 3			; lay bit thu 11 -15
	mov ah, 0			; cho ah ve 0 
	add ax, 1980		; + ax 1980, vi al khong du kich co 
	mov bHours, ax
	exit
main endp
end main