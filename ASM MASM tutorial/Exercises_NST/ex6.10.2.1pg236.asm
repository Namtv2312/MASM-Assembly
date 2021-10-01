.model flat, stdcall
ExitProcess proto, dwExitCode: dword
.data
memVal DWORD 12548476h
.code
main proc
mov al,BYTE PTR memVal
xor al,BYTE PTR memVal+1
xor al,BYTE PTR memVal+2
xor al,BYTE PTR memVal+3
invoke ExitProcess, 0
main endp
end main