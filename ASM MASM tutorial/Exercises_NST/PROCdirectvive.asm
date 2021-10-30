;main.asm
INCLUDE vars.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, exitcode:dword
.data
count dword ?
SYM1=1
.code
main proc
	mov count ,2000h
	mov eax, SYM1
	INVOKE ExitProcess, 0
main endp
end main