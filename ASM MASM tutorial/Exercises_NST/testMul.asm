Include Irvine32.inc
.data
	val1 word 2000h
	val2 word 0100h
.code
main:
	mov ax, val1
	mul val2

end main