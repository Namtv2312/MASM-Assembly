Include Irvine32.inc
.data
op1 BYTE 34h,12h,98h,74h,06h,0A4h,0B2h,0A2h
op2 BYTE 02h,45h,23h,00h,00h,87h,10h,80h
sum BYTE 9 dup(0)
.code
main PROC
	mov al, '7'
	add al, '3'
	aaa
	or ax, 3030h
mov esi,OFFSET op1 ; first operand
mov edi,OFFSET op2 ; second operand
mov ebx,OFFSET sum ; sum operand
mov ecx,LENGTHOF op1 ; number of bytes
call Extended_Add
; Display the sum.
mov esi,OFFSET sum
mov ecx,LENGTHOF sum
call Display_Sum
call Crlf
exit
main endp

Extended_Add PROC
 pushad
 clc
L1: mov al,[esi]
	adc al, [edi]
	pushfd
	mov [ebx],al
	add esi, 1
	add edi, 1
	add ebx,1 
	popfd
	loop L1

	mov byte ptr [ebx],0
	adc byte ptr [ebx],0
	popad
	ret
Extended_Add ENDP
Display_Sum PROC
pushad
; point to the last array element
add esi,ecx
sub esi,TYPE BYTE
mov ebx,TYPE BYTE

L1: mov al,[esi] ; get an array byte
call WriteHexB ; display it
sub esi,TYPE BYTE ; point to previous byte
loop L1
popad
ret
Display_Sum ENDP
end main
