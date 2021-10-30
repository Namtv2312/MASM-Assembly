Include Irvine32.inc
;.model small
.data
	BUFFER dword 255 dup (0)
.code
main:
	mov esi , offset BUFFER
	mov eax, -2023406815
	call BinToAsc
	exit
;---------------------------------------------------------
BinToAsc PROC
;
; Converts 32-bit binary integer to ASCII binary.
; Receives: EAX = binary integer, ESI points to buffer
; Returns: buffer filled with ASCII binary digits
;---------------------------------------------------------
	push ecx
	push esi
	mov ecx,32 ; number of bits in EAX
L1: shr eax,1 ; shift high bit into Carry flag
	mov BYTE PTR [esi],'0' ; choose 0 as default digit
	jnc L2 ; if no Carry, jump to L2
	mov BYTE PTR [esi],'1' ; else move 1 to buffer
L2: inc esi ; next buffer position
	loop L1 ; shift another bit to left
	pop esi
	pop ecx
ret
BinToAsc ENDP
end main