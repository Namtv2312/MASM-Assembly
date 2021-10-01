include Irvine32.inc
.model flat , stdcall
.code
main proc
mov dh,5
mov dl, 8
call SetCursorPosition
main endp

SetCursorPosition PROC
; Sets the cursor position. 
; Receives: DL = X-coordinate, DH = Y-coordinate. 
; Checks the ranges of DL and DH.
; Returns: nothing
;------------------------------------------------
.data
BadXCoordMsg BYTE "X-Coordinate out of range!",0Dh,0Ah,0
BadYCoordMsg BYTE "Y-Coordinate out of range!",0Dh,0Ah,0
.code
.IF (dl < 0) || (dl > 79)
mov edx,OFFSET BadXCoordMsg
 call WriteString
 jmp quit
.ENDIF
.IF (dh < 0) || (dh > 24)
mov edx,OFFSET BadYCoordMsg
 call WriteString
 jmp quit
.ENDIF
call Gotoxy
quit:
 ret
SetCursorPosition ENDP
end main