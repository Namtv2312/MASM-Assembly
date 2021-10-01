.386 
.model flat, stdcall
.stack 4096 
ExitProcess PROTO, dwExitCode: DWORD
.data?
Rval SDWORD ?
.data
	var1 SBYTE -4,-2,3,1
var2 WORD 1000h,2000h,3000h,4000h
var3 SWORD -16,-42
var4 DWORD 1,2,3,4,5
arr Dword 10h,20h,30h,40h
myBytes BYTE 10h,20h,30h,40h
oki label dword
myWords WORD 3 DUP(5),2000h
myString BYTE "ABCDE"
bigEdian BYTE 12h,34h, 56h,78h
littleEdian DWORD ?
.code 
main PROC	
	mov	esi, offset bigEdian
	mov al, [esi+3]
	mov ah, [esi+2]			; chuyen 56 va 78 cho ax
	mov ebx, 0
	mov bl, [esi+1]
	mov bh, [esi]			; chuyen 12 va 34 cho bx
	mov esi , offset littleEdian
	mov [esi], ax			; chuyen 5678 cho litte
	mov [esi+2], bx			; chuyen 1234 cho little
	mov eax, littleEdian
	
	INVOKE ExitProcess, 0
main ENDP
end main
