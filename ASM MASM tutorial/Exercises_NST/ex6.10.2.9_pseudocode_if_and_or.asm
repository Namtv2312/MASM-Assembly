.model flat, stdcall
ExitProcess proto, dwExitCode: dword
.data
		X dword ?
.code
main proc
	 cmp ebx , ecx
	 jbe L2
	 cmp ebx, edx
	 ja L3
L2:	 cmp edx, eax
	jbe L4
L3: MOV X,1
	jmp exit
L4: mov X,2

	

.IF ( ebx > ecx && ebx > edx) || (edx > eax)
			mov X, 1
.ELSE 
			mov X,2
.ENDIF
exit:
invoke ExitProcess, 0
main endp
end main