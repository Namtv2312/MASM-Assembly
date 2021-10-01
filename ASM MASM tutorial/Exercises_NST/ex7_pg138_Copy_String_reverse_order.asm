.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode :dword
.data
	source BYTE "This is the source string",0
	target BYTE SIZEOF source DUP('#')
.code
main proc
	mov esi, sizeof source -2		;chuyen esi den phan tu 'g'
	mov edi,0						; edi la phan tu des dau tien
	mov ecx, sizeof source -1		; ecx counter -1 ,bo qua nullterminated
	l1:
	mov al, source[esi]
	mov target[edi], al
	dec esi
	inc edi
	loop l1
	mov al ,00
	mov target[edi], al
	
	
invoke ExitProcess, 0
main endp
end main
