include Irvine32.inc

.386
.model flat , stdcall
.stack 4096
Clrscr proto
DumpMem proto
ExitProcess PROTO, dwExitCode: dword
.data
	COUNT =4
	BlueTextOnGray =blue + (lightGray *16)
	DefaultColor = lightGray +(black *16)
	arrayD SDWORD 12345678h, 1A4B2000h, 3434h, 7AB9h
	prompt BYTE "Enter a 32bit signed integer",0
.code
main proc 
	mov eax, BlueTextOnGray
	call SetTextColor
	call Clrscr
	mov esi, OFFSET arrayD
	mov ebx, TYPE arrayD
	mov ecx, lengthof arrayD
	call DumpMem
invoke ExitProcess, 0
main endp
end main