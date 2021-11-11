comment !
include uper.inc
include Irvine32.inc
.code
Uppercase PROC, character:BYTE
	cmp character, 'a'
	jb L1
	cmp character, 'z'
	ja L1
	sub al,32
L1: ret
uppercase endp
end
!

.386
.model flat, stdcall
.code
Uppercase PROC
	local temp:byte, swapfile:byte
	push ebp
	mov ebp,esp
	mov al,[esp+8]
	cmp al,'a'
	jb L1
	cmp al, 'z'
	ja L1
	sub al,32
L1:	pop ebp	
	ret 4
uppercase endp
END