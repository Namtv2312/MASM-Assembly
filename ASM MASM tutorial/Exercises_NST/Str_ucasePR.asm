include StrLibC.inc
.code
;-------------------------------------------------------
; Str_ucase
; Converts a null-terminated string to uppercase.
; Returns: nothing
;-------------------------------------------------------
Str_ucasee PROC USES eax esi, 
pString:PTR BYTE
mov esi,pString
L1:
mov al,[esi] ; get char
cmp al,0 ; end of string?
je L3 ; yes: quit
cmp al,'a' ; below "a"?
jb L2
cmp al,'z' ; above "z"?
ja L2
and BYTE PTR [esi],11011111b ; convert the char
L2: inc esi ; next char
jmp L1
L3: ret
Str_ucasee ENDP
end