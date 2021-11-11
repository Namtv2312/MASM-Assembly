include Irvine32.inc
include BinarySearch.inc
.code
;--------------------------------------------------------------
; BinarySearch
; Searches an array of signed integers for a single value.
; Receives: Pointer to array, array size, search value.
; Returns: If a match is found, EAX = the array position of the
; matching element; otherwise, EAX = -1.
;--------------------------------------------------------------
BinarySearch PROC USES ebx edx esi edi,
pArray:PTR DWORD, ; pointer to array
Count:DWORD, ; array size
searchVal:DWORD ; search value
LOCAL first:DWORD, ; first position
last:DWORD, ; last position
mid:DWORD ; midpoint
mov first,0 ; first = 0
mov eax,Count ; last = (count - 1)
dec eax
mov last,eax
mov edi,searchVal ; EDI = searchVal
mov ebx,pArray ; EBX points to the array
L1: ; while first <= last
mov eax,first
cmp eax,last
jg L5 ; exit search
; mid = (last + first) / 2
mov eax,last
add eax,first
shr eax,1
mov mid,eax
; EDX = values[mid]
mov esi,mid
shl esi,2 ; scale mid value by 4
mov edx,[ebx+esi] ; EDX = values[mid]
; if ( EDX < searchval(EDI) )
cmp edx,edi
jge L2
; first = mid + 1
mov eax,mid
inc eax
mov first,eax
jmp L4
; else if( EDX > searchVal(EDI) )
L2: cmp edx,edi ; optional
jle L3
; last = mid - 1
mov eax,mid
dec eax
mov last,eax
jmp L4
; else return mid
L3: mov eax,mid ; value found
jmp L9 ; return (mid)
L4: jmp L1 ; continue the loop
L5: mov eax,-1 ; search failed
L9: ret
BinarySearch ENDP
end