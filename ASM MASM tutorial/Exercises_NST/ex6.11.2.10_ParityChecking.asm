comment !
TITLE Parity Checking

; This program calculates the parity (even or odd) of the bytes in an
; array.

INCLUDE Irvine32.inc

True = 1
False = 0

.DATA
array1	BYTE	1,2,3,4,1,20,35,-12,66,4,6	; odd array
array2	BYTE	4,2,6,8,10,12,14,16,22,56,44	; even array

.CODE
main PROC
	mov	ebx,OFFSET array1	; point to the array
	mov	ecx,SIZEOF array1	; loop counter
	call	CheckParity
	call	WriteInt
	call	Crlf
	mov	ebx,OFFSET array2	; point to the array
	mov	ecx,SIZEOF array2	; loop counter
	call	CheckParity
	call	WriteInt
	call	Crlf
	exit
main ENDP

;-----------------------------------------------
CheckParity PROC USES ebx ecx
;
; Determines if there is an even or odd number of bits in the entire array.
; Receives: EBX points to the array, ECX = length of the array
; Returns: EAX = True if the parity is even, False if the parity is odd
;-----------------------------------------------------
	movzx	eax,BYTE PTR [ebx]	; EAX = value of first byte
	cmp		ecx,1			; arraySize <= 1 ?
	jle		DoneTraversing		; yes: jump straight to calculation
	dec		ecx				; loop for SIZEOF array - 1
TraverseArray:
	inc		ebx				; point to next byte
	xor		al,BYTE PTR [ebx]	; xor the current value with next byte
	loop		TraverseArray
DoneTraversing:
	jnp		OddParity
	mov		eax,True
	jmp		next
OddParity:
		mov	eax,False
next:
	ret
CheckParity ENDP
END main
!
COMMENT *Count the parity of 10byte array
eax = 0 (false) even parity
eax = 1 (true) even parity
*

INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data?
paritySum BYTE ?
numBits DWORD ?

.data
val1 DWORD 0000000fh

.code
main proc			
	xor ebx, ebx
	mov eax, DWORD PTR [val1]
	mov ecx, 32

	jmp BrianKalgorithm

	linear:					; this checks every LSB = 1 or 0 then bit shift right and repeat 
	test eax, 1				; if bit = 0, move to next bit
	jz bitNotset
	add ebx, 1				; bit is set, add counter
	bitNotset:				; no zero, shr 1, loop
	shr eax, 1				; move next bit to inspection slot
	sub ecx, 1
	jnz linear
	jmp linearfin
		
	notSolinear:				; like linear but exit early if left side bits are all 0
	test eax, 1				; if LSB = 0, move to next bit
	jz moveOn
	add ebx, 1				; bit is set, add population counter
	moveOn:						
	shr eax, 1				; move next bit to inspection slot
	jz notSolinearfin			; check if eax = 0, true = quit
	jmp notSolinear				; ecx loop counter not needed because it will exit on eax = 0

	BrianKalgorithm:
	test eax, eax				; check if eax = 0, true = quit
	jz BKfin			
	mov edx, eax				
	sub edx, 1				; by sub 1, it will reverse the right side bits
	AND eax, edx				; x & (x-1) removes most right bit
	add ebx, 1				; add population counter
	jmp BrianKalgorithm			; repeat

	BKfin:
	linearfin:
	notSolinearfin:

	AND ebx, 1
	jz itsEven
	mov eax, 0
	jmp finallyFin
	itsEven:
	mov eax, 1
	finallyFin:
	call WaitMsg
	INVOKE ExitProcess, 0
main endp

end main