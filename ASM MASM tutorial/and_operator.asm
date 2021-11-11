.386

.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode : dword
.data
	tableD DWORD 10h, 20h, 30h, 40h, 50h
Rowsize = ($ - tableD)
 DWORD 60h, 70h, 80h, 90h, 0A0h
 DWORD 0B0h, 0C0h, 0D0h, 0E0h, 0F0h

		array1 DWORD 1,2,3,4,5,6,7,8,9,10 ; test data
multiplier DWORD 10 ; test dat
		array byte "nam dep trai "
		len equ $- array
		string2 byte len dup(?)
		source word 2152h
		target word 5552h
.code
main proc
	mov ebx,Rowsize ; row index
mov esi,2 ; column index
mov eax,[tableD+ebx + esi*TYPE tableD]

cld
	
	mov esi,OFFSET array1 ; source index
mov edi,esi ; destination index
mov ecx,LENGTHOF array1 ; loop counter
L1: lodsd ; load [ESI] into EAX
mul multiplier ; multiply by a value
stosd ; store EAX into [EDI]
loop L1
invoke ExitProcess, 0
	mov esi,offset source
	mov edi ,offset array
	mov al, 'i'
	mov ecx, len
	cld
	rep stosb
	repne scasb
	jnz l2
	mov esi  ,offset array
	mov edi, offset string2
	mov ecx, 4
	rep movsb
	std
	mov ecx, 4
	rep movsb
 	mov ecx, lengthof array -1
	l2: and byte ptr[esi], 0dfh
	inc esi
	loop l2
	mov edx, offset array
	
invoke ExitProcess, 0
main endp
end main
