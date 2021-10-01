COMMENT !
	Author : Tran Van Nam
	date: 23-Sep- 21
	Shifting the Element in an Array
	Ex8 Trang 138 assembly
!

.386
.model flat, stdcall
.stack 4096


ExitProcess proto, dwExitCode:dword
.data
	array dword 1000h,20000h,30000h,40000h
.code
main proc
mov esi , offset  array		;esi = phan tu dau
mov eax, [esi]				;
mov ecx, lengthof array -1	; ecx counter vong loop
mov edi, 0					; index phan tu cuoi
l1:
mov ebx,[esi+type array]		; cho ebx giu gia tri thu 2
mov [esi+type array], eax		;chuyen gia tri dau vao gia tri thu hai
mov eax, ebx					;
add esi, type array				; tang esi 
loop l1

mov array[edi],eax			; CHUYEN NOt phan tu cuoi cung ve dau
invoke ExitProcess , 0
main endp
end main