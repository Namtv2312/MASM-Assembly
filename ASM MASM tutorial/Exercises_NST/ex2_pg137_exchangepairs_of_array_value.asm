.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitcode : dword
.data
	arry dword 1,2,3,4,5,6,7,8
.code
main PRoc
	mov ecx, 4 ;
	mov esi, offset arry
	l1:
	
	mov eax,dword ptr [esi]
	mov ebx, [esi +4]
	xchg eax, [esi+type arry]
	xchg ebx, [esi]
	add esi, 2* type arry
	loop l1
INVOKE ExitProcess, 0
main ENDP
end main