; Summing an Array (SumArray_64.asm)
ExitProcess PROTO
.data
intarray QWORD 1000000000000h,2000000000000h
QWORD 3000000000000h,4000000000000h

.code
main PROC
mov rbx,0FFFFFFFFFFFFFFFFh
and rbx,80808080h
mov rdi,OFFSET intarray ; RDI = address of intarray
mov rcx,LENGTHOF intarray ; initialize loop counter
mov rax,0 ; sum = 0
L1: ; mark beginning of loop
add rax,[rdi] ; add an integer
add rdi,TYPE intarray ; point to next element
loop L1 ; repeat until RCX = 0
mov ecx,0 ; ExitProcess return value
call ExitProcess
main ENDP
END