.386
.model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode :dword
.dat
			theSum dword ?
			ar dword 10h,20h,30h,40h
.code
main proc
			mov esi, offset ar
			mov ecx, lengthof ar
			call arraySum
			mov theSum, eax
invoke ExitProcess, 0
main endp


;-----------------------------------------------------
; ArraySum
;
; Calculates the sum of an array of 32-bit integers.
; Receives: ESI = the array offset
; ECX = number of elements in the array
; Returns: EAX = sum of the array elements
;-----------------------------------------------------

arraySum proc uses esi ecx
			;push esi		;save ESI, ECX; co the dung USES esi ecx
			;push ecx		; sau PROC DIRECTIVE de lam dieu tuong tu
			mov eax, 0		; set acculamtor ,sum =0
L1:			add eax, [esi]		; add moi so nguyen vao tong
			add esi, TYPE DWORD			; point to next integer
			loop L1							; repeat for array size

			;pop ecx					; restore ecx, esi
			;pop esi

			ret								; sum is in EAX
arraySum endp

end main
