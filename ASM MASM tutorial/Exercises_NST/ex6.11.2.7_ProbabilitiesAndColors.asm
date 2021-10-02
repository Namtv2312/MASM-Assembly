COMMENT # Generate 20 lines of text, each line colored with probability:
white	= 30%, 2 - 4 = 15
blue	= 10%, 1 = 9
green	= 60%, 5 - 10 = 2
eax SetTextColor


INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
prompt BYTE 'This is text colored with White(30%), Green(60%) or Blue(10%) probability.',0dh,0ah,0

.data?

.code
main proc
	call Randomize
	mov ecx, 20

begin:
	call rand10
	cmp eax, 1
	jnz not1
	mov eax, 9				; if eax = 1, set color to white & print text
	call SetTextColor
	call printText
	sub ecx, 1
	jnz begin
	jmp finished

not1:
	cmp eax, 5
	jge more5
	jmp less5

less5:						; eax = 2-4, use white(15)
	mov eax, 15
	call SetTextColor
	call printText
	sub ecx, 1
	jnz begin
	jmp finished

more5:						; eax= 5 or greater, use green(2)
	mov eax, 2
	call SetTextColor
	call printText
	sub ecx, 1
	jnz begin

finished:
	mov eax, 15				; restore normal text color
	call SetTextColor
	call WaitMsg
	INVOKE ExitProcess, 0
main endp

rand10 proc
	mov eax, 10				; generate random number 1-10
	call RandomRange
	add eax, 1			
	ret
rand10 endp

printText proc USES edx
	mov edx, OFFSET prompt
	call WriteString
	ret
printText endp

end main
#
TITLE Probabilities and Colours
; This program randomly chooses amongst three different colours for
; displaying text on the screen.
INCLUDE Irvine32.inc

.DATA
text	BYTE	"This is string will randomly change colours!",0Dh,0Ah,0

.CODE
main PROC
	call	Randomize
	mov	ecx,20					; 20 lines of text
PrintText:
	mov	eax,10					; generate a random integer between 0 and 9
	call	RandomRange
	cmp	eax,2					; 0 <= EAX <= 2 ?
	ja	NotWhite
	mov	eax,white + (black * 16)		; white = 30% probability
	jmp	done
NotWhite:
	cmp	eax,3					; EAX == 3 ?
	jne	NotBlue
	mov	eax,blue + (black * 16)		; blue = 10% probability
	jmp	done
NotBlue:							; 4 <= EAX <= 9 ?
		mov	eax,green + (black * 16)	; green = 60% probability
done:
	call	SetTextColor
	mov	edx,OFFSET text
	call	WriteString
	loop	PrintText

	mov	eax,lightGray + (black * 16)	; reset text colour
	call	SetTextColor
	call	Crlf
	exit
main ENDP
END main