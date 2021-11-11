include StrLibC.inc
;----------------
; nhan cac ham Str_compare , Str_length from Strlib
; Receipt:  ADDR source, ADDR target
;return: 
.data
	target BYTE "123ABC342432",0
	source BYTE "ABC",0
	pos DWORD ?
.code
main PROC
	INVOKE Str_find , ADDR source , ADDR target
	jnz notFound
	mov pos, eax
	exit
main ENDP

Str_find PROC 
	sourceStr:PTR BYTE,
	targetStr:PTR BYTE,
	local string1[3]:byte
	mov esi, sourceStr
	mov edi, targetStr

	; length of source: 
	invoke Str_length, sourceStr
	mov ebx, eax
	l1:
	cld
	mov ecx, ebx
	lea edi, string1
	mov esi, targetStr
	rep movsb

	invoke Str_compare, ADDR string1, sourceStr
	.IF ZERO?
	jmp l2
	inc esi,1
	cmp [esi],'0'
	jnz l1

	l2:ret





