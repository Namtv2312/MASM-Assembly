include StrLibC.inc
.code
;-----------------------------------------------------------
Str_comparee PROC USES eax edx esi edi,
string1:PTR BYTE,
string2:PTR BYTE
;
; Compares two strings.
; Returns nothing, but the Zero and Carry flags are affected
; exactly as they would be by the CMP instruction.
;-----------------------------------------------------------
mov esi,string1
mov edi,string2
L1: mov al,[esi]
mov dl,[edi]
cmp al,0 ; end of string1?
jne L2 ; no
cmp dl,0 ; yes: end of string2?
jne L2 ; no
jmp L3 ; yes, exit with ZF = 1
L2: inc esi ; point to next
inc edi
cmp al,dl ; characters equal?
je L1 ; yes: continue loop
 ; no: exit with flags set
L3: ret
Str_comparee ENDP
end