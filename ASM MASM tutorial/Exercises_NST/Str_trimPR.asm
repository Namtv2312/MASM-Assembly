include StrLibC.inc
.code
;------------------------------------------------------------
; Str_trim
; Remove all occurrences of a given delimiter
; character from the end of a string.
; Returns: nothing
;------------------------------------------------------------
Str_trimm PROC USES eax ecx edi,
pString:PTR BYTE, ; points to string
char: BYTE ; character to remove
mov edi,pString ; prepare to call Str_length
INVOKE Str_length,edi ; returns the length in EAX
cmp eax,0 ; is the length equal to zero?
je L3 ; yes: exit now
mov ecx,eax ; no: ECX = string length
dec eax 
add edi,eax ; point to last character
L1: mov al,[edi] ; get a character
 cmp al,char ; is it the delimiter?
 jne L2 ; no: insert null byte
 dec edi ; yes: keep backing up
loop L1 ; until beginning reached
L2: mov BYTE PTR [edi+1],0 ; insert a null byte
L3: ret
Str_trimm ENDP
end