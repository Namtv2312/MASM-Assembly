.386 
.model flat, stdcall
.stack 4096 
ExitProcess PROTO, dwExitCode: DWORD
.data
	source byte "Nam System dep trai",0
	desti byte sizeof source DUP (0)
.code 
main PROC
		mov esi , 0					;thanh ghi chi so	
		mov ecx, sizeof source		; chuyen bo dem loop : bang do dai soure in byte
		l1:
			mov al, source[esi]			; chuyen byte dau tien vao al	
			mov desti[esi], al			; chuyen byte tu al vao destination	
			inc esi							;tang chi so string
			loop l1
	INVOKE ExitProcess, 0
main ENDP
end main
