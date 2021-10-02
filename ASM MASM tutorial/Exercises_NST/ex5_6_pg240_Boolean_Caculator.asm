COMMENT !
INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
X = 00001111b
Y = 00000101b

caseTable	BYTE '1'				
		DWORD OFFSET proc1
entrySize = ($ - caseTable)				; size = 5 (1byte + 4bytes)
		BYTE '2'
		DWORD OFFSET proc2
		BYTE '3'
		DWORD OFFSET proc3
		BYTE '4'
		DWORD OFFSET proc4
		BYTE '5'
		DWORD OFFSET done
numEntry = ($ - caseTable) / entrySize
prompt		BYTE '1. x AND y', 0dh, 0ah				
		BYTE '2. x OR y', 0dh, 0ah					
		BYTE '3. NOT x', 0dh, 0ah					
		BYTE '4. x XOR y', 0dh, 0ah					 
		BYTE '5. Exit program', 0dh, 0ah
		BYTE 'Enter your selection (1-5): ', 0
strAND		BYTE ' AND ', 0
strOR		BYTE ' OR ', 0
strNOT		BYTE ' NOT ', 0
strXOR		BYTE ' XOR ', 0

.data?

.code
main proc
	mov esi, OFFSET caseTable
	mov edx, OFFSET prompt
	call WriteString
	call ReadChar
	call WriteChar
	mov ebx, 1
L1:
	cmp al, BYTE PTR [esi]			; compare input to first element in caseTable, call function if correct
	jnz next
	call Crlf
	call printBins
	mov eax, X
	call DWORD PTR [esi+1]
	jmp finish
next:
	add esi, entrySize
	jmp L1
finish:
	call WaitMsg
	INVOKE ExitProcess, 0
main endp

proc1 proc USES edx ebx
	mov edx, OFFSET strAND
	call WriteString
	call Crlf
	AND eax, Y
	call WriteBinB
	call Crlf
	ret
proc1 endp
	
proc2 proc USES edx ebx
	mov edx, OFFSET strOR
	call WriteString
	call Crlf
	OR eax, Y
	call WriteBinB
	call Crlf
	ret
proc2 endp

proc3 proc USES edx ebx
	mov edx, OFFSET strNOT
	call WriteString
	call Crlf
	NOT eax
	call WriteBinB
	call Crlf
	ret
proc3 endp

proc4 proc USES edx ebx
	mov edx, OFFSET strXOR
	call WriteString
	call Crlf
	XOR eax, Y
	call WriteBinB
	call Crlf
	ret
proc4 endp

printBins proc USES eax ebx
	mov eax, X
	mov ebx, 1
	call WriteBinB
	call Crlf
	mov eax, Y
	call WriteBinB
	ret
printBins endp

done proc
	exit
done endp
end main
!
TITLE Boolean Calculator
; This program functions as a simple boolean calculator for 32-bit
; integers.
INCLUDE Irvine32.inc

.DATA
CaseTable	BYTE		'1'		; lookup value
		DWORD	AND_op	; address of procedure
EntrySize = ($ - CaseTable)
		BYTE		'2'
		DWORD	OR_op
		BYTE		'3'
		DWORD	NOT_op
		BYTE		'4'
		DWORD	XOR_op
NumberOfEntries = ($ - CaseTable) / EntrySize
prompt	BYTE	"Please make a selection from the following list by pressing the corresponding digit:",0Dh,0Ah
		BYTE	"1. x AND y",0Dh,0Ah
		BYTE	"2. x OR y",0Dh,0Ah
		BYTE	"3. NOT x",0Dh,0Ah
		BYTE	"4. x XOR y",0Dh,0Ah
		BYTE "5. Exit program",0Dh,0Ah,0Dh,0Ah
		BYTE "Your Selection: ",0
msg1		BYTE	"AND_op",0Dh,0Ah,0
msg2		BYTE	"OR_op",0Dh,0Ah,0
msg3		BYTE	"NOT_op",0Dh,0Ah,0
msg4		BYTE	"XOR_op",0Dh,0Ah,0
xPrompt	BYTE	0Dh,0Ah,"Please enter the value of x in hexadecimal: ",0
yPrompt	BYTE	0Dh,0Ah,"Please enter the value of y in hexadecimal: ",0

.DATA?
x		DWORD	?
y		DWORD	?

.CODE
main PROC
	mov	edx,OFFSET prompt		; ask user for input
	call	WriteString
	call	ReadChar				; read character into AL
	mov	ebx,OFFSET CaseTable	; point EBX to the table
	mov	ecx,NumberOfEntries		; loop counter
TraverseCaseTable:
	cmp	al,[ebx]				; match found?
	jne	Continue				; no: continue
	call	NEAR PTR [ebx + 1]		; yes: call the procedure
	call	Crlf
	jmp	done					; exit the search
Continue:
	add	ebx,EntrySize			; point to the next entry
	loop	TraverseCaseTable
done:
	exit
main ENDP

.DATA
andResult	BYTE	" AND ",0
equals	BYTE	" = ",0

.CODE
AND_op PROC
	mov	edx,OFFSET msg1
	call	GetX
	call	GetY
	call	Crlf

	mov	eax,x
	call	WriteHex				; display x
	mov	edx,OFFSET andResult
	call	WriteString			; display " AND "
	mov	eax,y
	call	WriteHex				; display y
	mov	edx,OFFSET equals
	call	WriteString			; display " = "
	mov	eax,x
	and	eax,y
	call	WriteHex				; display result
	call	Crlf
	ret
AND_op ENDP

.DATA
orResult	BYTE	" OR ",0

.CODE
OR_op PROC
	mov	edx,OFFSET msg2
	call	GetX
	call	GetY
	call	Crlf

	mov	eax,x
	call	WriteHex				; display x
	mov	edx,OFFSET orResult
	call	WriteString			; display " OR "
	mov	eax,y
	call	WriteHex				; display y
	mov	edx,OFFSET equals
	call	WriteString			; display " = "
	mov	eax,x
	or	eax,y
	call	WriteHex				; display result
	call	Crlf
	ret
OR_op ENDP

.DATA
notResult	BYTE	"NOT ",0

.CODE
NOT_op PROC
	mov	edx,OFFSET msg3
	call	GetX
	call	Crlf

	mov	edx,OFFSET notResult
	call	WriteString			; display "NOT "
	mov	eax,x
	call	WriteHex				; display x
	mov	edx,OFFSET equals
	call	WriteString			; display " = "
	mov	eax,x
	not	eax
	call	WriteHex				; display result
	call	Crlf
	ret
NOT_op ENDP

.DATA
xorResult	BYTE	" XOR ",0

.CODE
XOR_op PROC
	mov	edx,OFFSET msg4
	call	GetX
	call	GetY
	call	Crlf

	mov	eax,x
	call	WriteHex				; display x
	mov	edx,OFFSET xorResult
	call	WriteString			; display " XOR "
	mov	eax,y
	call	WriteHex				; display y
	mov	edx,OFFSET equals
	call	WriteString			; display " = "
	mov	eax,x
	xor	eax,y
	call	WriteHex				; display result
	call	Crlf
	ret
XOR_op ENDP

GetX PROC
	call	WriteString			; display message
	mov	edx,OFFSET xPrompt
	call	WriteString			; get x
	call	ReadHex
	mov	x,eax
	ret
GetX ENDP

GetY PROC
	mov	edx,OFFSET yPrompt
	call	WriteString			; get y
	call	ReadHex
	mov	y,eax
	ret
GetY ENDP
END main