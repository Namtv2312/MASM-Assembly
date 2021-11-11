include Irvine32.inc
.data
count=100
array WORD count DUP(?)
.code
main proc
push offset array
push count
call ArrayFill
main endp

ArrayFill proc
	push ebp				;de view duoc gia tri cua stack (long int*)EBP: kieu tro (sometype)object: ep kieu
	mov ebp, esp			;luon luon noi den offset: ebp tro den offset cua esp chua gia tri cua esp

	pushad					;push 8 thanh ghi, 32byte: esp -32 di
	mov esi, [ebp+12]		; offset cua mang				: esi lay content tai dia chi ebp+12
	mov ecx, [ebp+8]		; array length: counter
	cmp ecx, 0				; so sanh ecx, 0
	je L2					; = thì skip over loop
L1:
	mov eax, 10000h			; get random 0- FFFFh
	call RandomRange		;link library
	mov [esi], ax			; insrt value in array
	add esi, type WORD		; mov to next element
	loop L1
L2: popad					; restore register
	pop ebp
	ret 8					; clean up the stack
ArrayFill ENDP
end main

