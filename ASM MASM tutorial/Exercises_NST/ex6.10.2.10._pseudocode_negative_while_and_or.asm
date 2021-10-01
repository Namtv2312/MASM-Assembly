.model flat, stdcall
ExitProcess proto, dwExitCode: dword
.data
	N sdword ?
	A SDWORD ?
	B SDWORD ?
.code
main PROC
	mov eax, A
	mov edx, B
L0: cmp N,0
	jle exit
	cmp N,3
	je L2
	cmp N,eax
	jl L1
	cmp N,edx
	jle L2
L1: sub N,2
jmp L0
L2: sub N,1
	jmp L0
exit:

.WHILE N>0
	.IF N!=3 && ( N<eax || N>edx)
			sub N,2
	.ELSE 
			dec N
	.ENDIF
.ENDW

invoke ExitProcess ,0
main endp
end main