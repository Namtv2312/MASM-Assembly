.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword
.data
	N=50
	K dword ?
	array byte N dup(?)
.code
	main Proc
		mov K,2
		call multiples_k
		mov esi, offset array
		mov ecx, N
		l1:
		mov word ptr [esi],0
		loop l1
		mov K,3
		call multiples_K
	invoke ExitProcess, 0
	main endp
	multiples_k proc uses ecx esi ebx edx
		mov esi, offset array
		mov ecx, N						;so vong lap
		mov edx, 1						;So tu 1 den N
		mov ebx, K						; Tich cua K
		l1:
		CMP ebx, edx					;so sanh de tim ra vi tri multi cua X
		jne next						;phan tu dau khong phai thi phan tu tiep theo
		; if =
		mov byte ptr [esi],1			;bang nhau thi, cho phan tu mang =1 
		add ebx, k						; (x+1)*k
					
		next:							; phan tu tiep theo
		inc edx							;phan tu tiep theo
		add esi, type array				;phan tu mang tiep theo 01010101
		loop l1
		ret
	multiples_k endp
	end main