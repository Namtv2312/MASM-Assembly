INCLUDE StrLibC.INC
 .code
Str_lengthh PROC USES edi,
pString:PTR BYTE ; pointer to string
mov edi,pString
mov eax,0 ; character count
L1: cmp BYTE PTR[edi],0 ; end of string?
je L2 ; yes: quit
inc edi ; no: point to next
inc eax ; add 1 to count
jmp L1
L2: ret
Str_lengthh ENDP
end