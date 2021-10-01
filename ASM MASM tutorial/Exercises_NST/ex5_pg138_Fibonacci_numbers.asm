.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword
.data
	Fib dword 7 dup (?)
.code
main proc
	mov ecx, 6	
	mov eax, 1
	mov [Fib], eax
	mov [Fib+4], eax	
	mov esi, offset Fib
	l1:

	mov eax, [esi]
	mov ebx, [esi+4]
	add eax, ebx
	mov [esi +8], eax
	add esi , 4
	loop l1

	


invoke ExitProcess, 0
main endp
end main