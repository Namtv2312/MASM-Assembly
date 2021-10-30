Include Irvine32.inc
.data
.code
	main proc
	mov al, 63
	rol al,2
	
	main endp
.data
array DWORD 648B2165h,8C943A29h,6DFA4B86h,91F76C04h,8BAF9857h
.code
MOV bh,0
or bh,1
mov bl,4 ; shift count
mov esi,OFFSET array ; offset of the array
mov ecx,4 ; number of array elements
L1: push ecx ; save loop counter
mov eax,[esi + TYPE DWORD]
mov cl,bl ; shift count
shrd [esi],eax,cl ; shift EAX into high bits of
add esi,TYPE DWORD ; point to next doubleword pair
pop ecx ; restore loop counter
loop L1
shr DWORD PTR [esi],4 ; shift the last doubleword
	end main
