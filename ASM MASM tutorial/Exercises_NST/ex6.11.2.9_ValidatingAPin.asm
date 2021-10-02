COMMENT *Validate PIN using specified int range for each PIN.
1st PIN must be between 5 - 9
2nd PIN must be between 2 - 5
3rd PIN must be between 4 - 8
4th PIN must be between 1 - 4
5th PIN must be between 3 - 6
- Generate 10 random 5 digit PIN 
- Check each pin digit according their range
- Display if they are valid/invalid, colored to red(4) if invalid, green(2) if valid next to the PIN
- White(15)


INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data?
PINarray BYTE 5 DUP (?)

.data
validStr	BYTE ' is valid PIN', 0dh, 0ah, 0	
invalidStr	BYTE ' is invalid PIN', 0dh, 0ah, 0
rangeTable	BYTE '5'				; set range lookup table mapped to ecx counter 
		DWORD OFFSET digitRange1
rangeSize = ($ - rangeTable)
		BYTE '4'
		DWORD OFFSET digitRange2
		BYTE '3'
		DWORD OFFSET digitRange3
		BYTE '2'
		DWORD OFFSET digitRange4
		BYTE '1'
		DWORD OFFSET digitRange5
tableEntries = ($ - rangeTable) / rangeSize

.code
main proc						
	call Randomize
	mov ecx, 1000
	loopy:
		mov esi, OFFSET PINarray
		mov edi, OFFSET rangeTable
		call genRanPIN			
		call validatePIN
		call writeResult
		sub ecx, 1
		jnz loopy
	call WaitMsg
	INVOKE ExitProcess, 0
main endp

;===================================
; writeResult - print colored valid/invalid string depending on input
; INPUT:	[eax] 1 = invalid, 0 valid
; Returns:	None
;===================================
writeResult proc USES eax
	mov edx, OFFSET PINarray
	call WriteString
	test eax, eax				; check if eax = 0 (valid) or 1 (invalid)
	jnz invalid
	mov eax, 2				; set green text color
	call SetTextColor
	mov edx, OFFSET validStr
	call WriteString
	jmp finish
	invalid:
		mov eax, 4			; set text color to red
		call SetTextColor
		mov edx, OFFSET invalidStr
		call WriteString
	finish:
	mov eax, 15				; restore text to white
	call SetTextColor
	ret
writeResult endp

;===================================
; validatePIN - validates PIN set
; INPUT:	[esi] ptr to array initialised with random digits
;		[edi] range table pointer
; Returns:	[eax] 0=valid, 1=invalid
;===================================
validatePIN proc USES esi ebx ecx
	mov ecx, LENGTHOF PINarray
	digitloop:
		call DWORD PTR [edi+1]		; call function to set N-th digit range
		call validateDigit		; validate digit using supplied range
		test eax, eax
		jnz finish			; eax = 1, invalid digit, exit
		add esi, TYPE PINarray		; move to next random pin
		add edi, rangeSize		; move to next ecx mapped range table 
		sub ecx, 1
		jnz digitloop
	finish:
	ret
validatePIN endp

;====================================
; validateDigit - validates a digit to supplied low/high range
; INPUT: [bl] low range, [bh] high range, [esi] array ptr
; Returns: [eax] 0=valid, 1=invalid
;====================================
validateDigit proc USES ebx esi
	mov al, BYTE PTR [esi]
	cmp al, bl			; check if less than low range
	jl invalid
	cmp al, bh			; check if greater than high range
	jg invalid
	mov eax, 0			; al is bigger than low range, less than high range (valid)
	jmp finish
	invalid:
		mov eax, 1
	finish:
		ret
validateDigit endp

;====================================
; genRan10 - generate random number between 1-9
; INPUT: None
; OUTPUT: [eax] random number 1-9
;====================================
genRan10 proc
	mov eax, 9
	call RandomRange
	add eax, 1
	ret
genRan10 endp

;====================================
; genRanPIN - write 5 random number to suppiled uninitialised array
; INPUT: [esi] ptr to un-init array
; Returns: none, write pin to array
;====================================
genRanPIN proc USES eax ecx esi
	mov esi, OFFSET PINarray
	mov ecx, LENGTHOF PINarray
	pinloop:
		call genRan10
		add al, 48			; convert to ascii letter so it is printable
		mov BYTE PTR[esi], al		; fill the 5 digit array
		add esi, 1
		sub ecx, 1
		jnz pinloop
		ret
genRanPIN endp

;====================================
; digitRange1 - set acceptable range for 1st digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
;====================================
digitRange1 proc
	mov bl, 35h
	mov bh, 39h
	ret
digitRange1 endp

; ====================================
; digitRange2 - set acceptable range for 2nd digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
; ====================================
digitRange2 proc
	mov bl, 32h
	mov bh, 35h
	ret
digitRange2 endp

; ====================================
; digitRange3 - set acceptable range for 3rd digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
; ====================================
digitRange3 proc
	mov bl, 34h
	mov bh, 38h
	ret
digitRange3 endp

; ====================================
; digitRange4 - set acceptable range for 4th digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
; ====================================
digitRange4 proc
	mov bl, 31h
	mov bh, 34h
	ret
digitRange4 endp

; ====================================
; digitRange5 - set acceptable range for 5th digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
; ====================================
digitRange5 proc
	mov bl, 33h
	mov bh, 36h
	ret
digitRange5 endp

end main
*
TITLE Validating a PIN
; This program validates a number of 5-digit PINs to ensure the values are
; within the specified ranges.
INCLUDE Irvine32.inc

PIN_LENGTH = 5

.DATA
pin1		BYTE	5,2,4,1,3	; valid PIN
pin2		BYTE	4,3,5,3,4	; first digit out of range
pin3		BYTE	6,4,5,3,7	; last digit out of range
pin4		BYTE	7,4,6,3,5	; valid PIN

.CODE
main PROC
	mov	esi,OFFSET pin1
	call	Output
	mov	esi,OFFSET pin2
	call	Output
	mov	esi,OFFSET pin3
	call	Output
	mov	esi,OFFSET pin4
	call	Output
	exit
main ENDP

.DATA
minVals	BYTE	5,2,4,1,3
maxVals	BYTE	9,5,8,4,6

.CODE
; This procedure validates each digit of the PIN.
; Receives:	ESI points to the PIN
; Returns:	EAX = position of invalid digit or 0 if PIN is valid
Validate_PIN PROC USES ecx edi esi
	mov	edi,0			; index of value arrays
	mov	ecx,PIN_LENGTH		; loop counter
TraversePIN:
	mov	al,[esi]			; current digit of PIN
	cmp	al,minVals[edi]	; is al < minVals[edi] ?
	jb	ReturnIndex		; if yes, immediately return
	cmp	al,maxVals[edi]	; is al > maxVals[edi] ?
	jbe	NextDigit			; if no, continue
ReturnIndex:
	mov	eax,edi		; return index of invalid digit
	inc	eax
	jmp	done
NextDigit:
	inc	esi
	inc	edi
	loop	TraversePIN
	mov	eax,0			; all digits are valid
done:
	ret
Validate_PIN ENDP

.DATA
valid	BYTE	"Valid",0
invalid	BYTE	" digit is invalid",0

.CODE
Output PROC USES edx
	call	Validate_PIN
	or	eax,eax			; EAX == 0 ?
	jne	NotValid			; if no, invalid
	mov	edx,OFFSET valid	; "Valid"
	call	WriteString
	jmp	IsValid
NotValid:
		call	WriteDec		; # " digit is invalid"
		mov	edx,OFFSET invalid
		call	WriteString
IsValid:
	call	Crlf
	ret
Output ENDP
END main