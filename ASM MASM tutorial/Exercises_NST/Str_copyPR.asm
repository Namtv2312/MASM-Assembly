include StrLibC.inc
.code
;--------------------------------------------------------
Str_copyy PROC USES eax ecx esi edi,
 source:PTR BYTE, ; source string
 target:PTR BYTE ; target string
;
; Copies a string from source to target.
; Requires: the target string must contain enough
; space to hold a copy of the source string.
;--------------------------------------------------------
INVOKE Str_length,source ; EAX = length source
mov ecx,eax ; REP count
inc ecx ; add 1 for null byte
mov esi,source
mov edi,target
cld ; direction = forward
rep movsb ; copy the string
ret
Str_copyy ENDP
end