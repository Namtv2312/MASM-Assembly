.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode :dword
.data
	arr16 word 1234h,5678h,2234h,6789h
	arr32 dword ?
	
.code
main proc
	mov esi, 0
	mov edi, 0
	mov ecx, lengthof arr16
	l1:
	mov ax, arr16[esi]
	movzx eax, ax
	mov [arr32+edi], eax
	add esi, type arr16
	add edi, type arr32
	loop l1
invoke ExitProcess,0
main endp
end main