; Sum of Integers (RecursiveSum.asm)
INCLUDE Irvine32.inc
.code
main PROC
mov ecx,5 ; count = 5
mov eax,0 ; holds the sum
call CalcSum ; calculate sum
L1: call WriteDec ; display EAX
call Crlf ; new line
exit
main ENDP
;----------------------------------------------------
CalcSum PROC
; Calculates the sum of a list of integers
; Receives: ECX = count
; Returns: EAX = sum
;----------------------------------------------------
cmp ecx,0 ; check counter value
jz L2 ; quit if zero
add eax,ecx ; otherwise, add to sum
dec ecx ; decrement counter
call CalcSum ; recursive call
L2: ret
CalcSum ENDP
end Main