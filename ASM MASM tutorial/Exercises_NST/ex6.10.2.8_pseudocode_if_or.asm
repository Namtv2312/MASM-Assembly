.model flat ,stdcall
ExitProcess proto, dwExitCode: dword
.data
 X dword ?
 val1 dword 0
.code
main proc
	;method disadd
	cmp ebx, ecx
	ja L1
	cmp ebx, val1
	jbe L2
L1: mov X,1
jmp  main +22h
L2: MOV X,2
  .if ( ebx>ecx) || (ebx > val1)
		mov X,1
	.else 
		mov X,2

	.endif

invoke ExitProcess ,0
main endp
end main