.386
.model flat ,stdcall
.stack 4096
ExitProcess proto, dwExitCode : dword
.data
 array dword 0,2,5,9,10
.code
main PROC
	mov esi, offset array
	mov ecx, lengthof array-1
	mov eax, 0
	l1:
	mov ebx, [esi+4]
	sub ebx, [esi]
	add eax, ebx
	add esi, 4
	loop l1
invoke ExitProcess, 0
main ENDp
end main
