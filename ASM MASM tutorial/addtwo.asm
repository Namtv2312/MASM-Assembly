include Irvine32.inc
.code
example proc
	call AddTwo
	exit
example endp

AddTwo proc
	push ebp
	mov ebp, esp
	sub esp , 32
	lea esi, [ebp-30]
	mov ecx, 30
L1:
	MOV BYTE ptr [esi], '*'
	inc esi
	loop L1
	add esp,32
	pop ebp
	ret
AddTwo endp
end example