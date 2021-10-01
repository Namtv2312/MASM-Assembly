.model flat, stdcall
ExitProcess proto, dwExitCode: dword
.data
	X dword ?
	val1 dword 0
	val2 dword 0
.code
main proc
		;method excellent
		cmp val1, ecx
		jbe L5
		cmp ebx, val1
		jbe L5
		mov X,1
		jmp exit
	L5: mov X,2
.if ( val2 > ecx ) && ( ecx > edx ) 
		mov X, 1
.else
			;method learnself
			mov X, 2
			.ENDIF

	cmp val1, ecx
	ja L1
	cmp ebx, val1
	ja L1
	jmp L2
L1: mov X,1
jmp exit
L2: mov X,2

	
exit:

invoke ExitProcess,0
main endp
end main

