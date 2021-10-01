include Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:dword
.data
	counter dword ?
.code
main proc
	mov ecx, 5
	mov eax, 0
	call recursive
	mov counter , eax
	mov eax, counter
	call WriteDec						; if you want display to console window: use Lib or write code
invoke ExitProcess, 0
main endp
; ham de quy
; receive : ECX : counter
; eax : bo tich luy: accumulator
recursive proc 
	loop l1						;loop first , so it alway used, to dec ECX, 
	ret							; when ecx=0, no loop, ret is used... back to main
	l1:
		add eax, 1			;add 1 to accumulator
		call recursive
		ret
recursive endp
end main


	
