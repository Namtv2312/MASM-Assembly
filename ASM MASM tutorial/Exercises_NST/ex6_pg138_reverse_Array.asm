.386
.model flat, stdcall
ExitProcess proto, dwExitCode :dword
.data
	arr dword 1235h, 5678h,7654h, 2245h, 6789h
.code
main proc
	mov esi, offset arr				;offset vi tri dau
	mov edi, offset arr+ sizeof arr	; offset vi tri cuoi
	sub edi, type arr				;
	mov eax, 0
	mov ebx,0
	mov ecx, lengthof arr /2 
	l1:
	mov eax, [esi]				
	mov ebx, [edi]
	xchg eax, ebx			;arr[sorce]= arr[dess]
	mov [esi], eax	
	mov [edi], ebx

	add esi, type arr			; sorce ++, dess --
	sub edi, type arr
	loop l1					; loop
invoke ExitProcess, 0
main endp
end main