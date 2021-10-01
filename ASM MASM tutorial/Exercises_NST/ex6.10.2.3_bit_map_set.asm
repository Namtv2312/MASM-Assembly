.model flat, stdcall
ExitProcess proto, dwExitCode:dword
.data
SetX dword 110100000b
SetY dword 001100000b
.code
main proc
	; find member setX not member SetY
	mov eax, SetX
	mov edx, SetY
	not edx
	and eax, edx

	;method union
	mov eax, SetX
	mov edx, SetY
	 or eax, edx
	 sub eax, edx

	 ;method X (XY) Y
	 mov eax, SetX
	 mov edx, SetY
	 and edx, eax
	 sub eax, edx

	invoke ExitProcess, 0
main endp
end main

