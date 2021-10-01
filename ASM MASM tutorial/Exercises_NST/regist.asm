.model flat ,stdcall
include Irvine32.inc

.code

main proc
call regis
main endp

regis proc
.data
TRUE = 1
FALSE = 0
gradeAverage WORD 275 ; test value
credits WORD 12 ; test value
OkToRegister BYTE ?
.code

mov eax,0
.REPEAT
inc eax
call WriteDec
call Crlf
.UNTIL eax == 10
mov OkToRegister,FALSE
.IF gradeAverage > 350
 mov OkToRegister,TRUE
.ELSEIF (gradeAverage > 250) && (credits <= 16)
 mov OkToRegister,TRUE
.ELSEIF (credits <= 12)
 mov OkToRegister,TRUE
.ENDIF
regis endp
end main