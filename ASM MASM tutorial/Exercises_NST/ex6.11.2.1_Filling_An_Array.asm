TITLE Filling an Array
COMMENT !
	INCLUDE Irvine32.inc

N=10
.data
array DWORD N DUP(?)
j DWORD ?
k DWORD ?
.code
    main PROC
        call Clrscr
        mov j, -10
        mov k, 10
        mov ESI, OFFSET array
        mov ECX, N
        call FillingAnArray

        mov j, 100
        mov k, 1000
        mov ESI, OFFSET array
        mov ECX, N
        call FillingAnArray
      
        call WaitMsg
        exit
    main ENDP

    FillingAnArray PROC
        push ecx
        push esi

        l1:
            mov eax, j
            mov ebx, k

            dec ebx  
            sub ebx, eax        ;create range from 0 to N
            xchg ebx, eax        ;random works with eax
            call RandomRange    ; generate random int witin range 0 to N
            neg ebx                ;change sign of ebx
            sub eax, ebx        ;sub from eax to define range
            call crlf
            call WriteInt

            mov [esi], eax
            add esi, 4
        loop l1

        pop esi
        pop ecx
        ret
    FillingAnArray ENDP

END main
!
; This program fills an array of doublewords with N random integers in the
; range j...k inclusive.
INCLUDE Irvine32.inc

N = 7

.DATA
promptj	BYTE		"Lowest value in range: ",0
promptk	BYTE		"Highest value in range: ",0

.DATA?
dArray	DWORD	N DUP(?)
j		DWORD	?
k		DWORD	?

.CODE
main PROC
	call	Clrscr
	call	GetInput
	call	FillArray
	mov	esi,OFFSET dArray
	mov	ecx,N
	mov	ebx,TYPE dArray
	call	DumpMem
	call	Crlf
	call	GetInput
	call	FillArray
	mov	esi,OFFSET dArray
	mov	ecx,N
	mov	ebx,TYPE dArray
	call	DumpMem
	call	Crlf
	exit
main ENDP

; Returns:	j = low range, k = high range
GetInput PROC USES edx eax
	mov	edx,OFFSET promptj
	call	WriteString
	call	ReadInt
	mov	j,eax
	mov	edx,OFFSET promptk
	call	WriteString
	call	ReadInt
	mov	k,eax
	ret
GetInput ENDP

; Receives:	ESI = pointer to array, N, j, k
; Returns:	dArray = filled array
FillArray PROC USES esi ecx eax ebx
	mov	esi,OFFSET dArray
	mov	ecx,N
TraverseArray:
	mov	eax,k
	mov	ebx,j
	sub	eax,ebx
	add	eax,1
	call	RandomRange
	add	eax,j
	mov	[esi],eax
	add	esi,TYPE dArray
loop TraverseArray
	ret
FillArray ENDP
END main
