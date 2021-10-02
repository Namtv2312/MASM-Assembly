Include Irvine32.inc
.data
	StringA	byte "abcdaa",0
	Substring byte "a",0
	Invalid byte "Xong", 0
	lenS = lengthof Substring -1
.code
	main proc
	mov esi, offset StringA
	mov edi, offset Substring
	call findSubstring
	main endp
findSubstring proc 
	mov edx,0
	mov ecx, lengthof StringA -1
TraveralStringA:
	mov al,[esi]
	cmp al , [edi]
	jne nextchar
	inc esi
	inc edi
	inc edx
	mov bl,0
	cmp [edi], bl
	je complete
	cmp edx, ecx
	ja noFound
nextchar:
	inc esi
	inc edx
	mov edi, offset Substring
	jmp TraveralStringA
complete:
	sub edx, lenS
	mov eax, edx
	call WriteInt
	call Crlf
	add edx, lenS
	cmp edx, ecx
	jae noFound
	dec esi
	dec edx
	
	jmp nextchar
noFound:
	mov edx, offset Invalid
	call WriteString
	exit
findSubstring endp
end main