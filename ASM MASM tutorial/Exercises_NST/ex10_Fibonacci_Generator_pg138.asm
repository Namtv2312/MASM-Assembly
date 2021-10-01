.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode : dword
.data
		N =47		
		FibArray  dword 1,1, N-2  dup (?)
.code 
	main proc
		mov esi, offset FibArray
		mov ecx, N-1
		call solveFib
	invoke ExitProcess, 0
	main endp

	solveFib proc uses esi ecx
	l1:
	mov eax, [esi]
	mov ebx, [esi+type FibArray]
	add eax, ebx
	mov [esi +8], eax
	add esi ,type FibArray
	loop l1
	ret

	solveFib endp
	end main