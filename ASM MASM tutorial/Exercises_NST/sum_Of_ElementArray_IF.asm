.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode : dword
.data
sum DWORD 0
sample DWORD 50
array Dword 10,60, 20, 33, 72, 89,45, 65, 72, 18
ArraySize = LENGTHOF array
.code
main proc
	mov eax, 0
	mov edx, sample
	mov esi, 0
	mov ecx, ArraySize
L1: cmp esi, ecx
	jl L2
	jmp L5
L2:
	cmp array[esi*4], edx				; use sclae factor: esi: index, 4 : type dword
	jg L3
	inc esi
	jmp L1
L3: add eax, array[esi*4]
	inc esi
	jmp L1
L5: mov sum, eax
invoke ExitProcess ,0
main endp
end main