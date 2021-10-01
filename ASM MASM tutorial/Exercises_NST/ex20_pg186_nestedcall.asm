.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: dword
.data
	array DWORD 4 dup (0)
.code
main proc
	mov eax, 10
	mov esi, 0
	call proc_1
	add esi, 4
	add eax, 10
	mov array[esi], eax
	invoke ExitProcess, 0
main endp
 
 proc_1 PROC
 call proc_2
add esi,4
add eax,10
mov array[esi],eax
ret
proc_1 ENDP
proc_2 PROC
call proc_3
add esi,4
add eax,10
mov array[esi],eax
ret
proc_2 ENDP
proc_3 PROC
mov array[esi],eax
ret
proc_3 ENDP
end main
	