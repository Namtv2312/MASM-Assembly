.386
.model flat, stdcall
.stack 4096 
ExitProcess PROTO, dwExitCode: DWORD
.data
		myBytes BYTE 10h,20h,30h,40h
.code 
main PROC
		mov eax, 0				
		mov ecx, lengthof mybytes  
		mov esi, offset myBytes		
		l1:
			add al, [esi]		
			add esi, type myBytes	
			loop l1				
	INVOKE ExitProcess, 0
main ENDP
end main
