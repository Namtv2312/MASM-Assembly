include Irvine32.inc
.model flat , stdcall
.code
mainn :
	mov EAX, 10
	mov ebx, eax
	mov edx, eax
	shl eax, 4
	shl ebx, 2
	shl edx, 0
	add eax, ebx
	add eax, edx
	exit
end mainn

