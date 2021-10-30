Include Irvine32.inc
.code
main proc
	mov ax, 0408h
	aad
	mov al, 05h
	mov bl, 09h
	mul bl
	aam
	mov al, '5'
	sub al , '7'
	aas
	pushf
	or al, 30h
	popf
	mov dl, 0
	mov al, 0ffh
	add al, 0ffh
	adc dl, 0
	mov dx, 0ffh
	mov ax, 01h
	mov cx, 0ffh
	div cx
	mov dx, 05ffh
	imul ax, dx
	mov ax, 7300h
	mov dx, 0101101000000000b
	shld dx, ax, 16
	mov al, 27h
	ror al,4
	mov al, 0afh
	sar al,1
	mov dl,0
	mov al, 0FFh
	add al, 0FFh
	adc dl, 0
main endp
SomeFunction proc
	mov eax, 123
	ret
SomeFunction endp
end main