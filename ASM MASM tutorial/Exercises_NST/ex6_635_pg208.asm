.386
.model flat, stdcall
.stack 4096

.code
main proc
mov ax, 8109h
cmp ax, 26h
jg a
jng b
a: mov eax, 0
b: mov eax,1
main endp
end main