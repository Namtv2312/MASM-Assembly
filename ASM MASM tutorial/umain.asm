comment !
include Irvine32.inc
include uper.inc
.data 
	character byte 'x'
.code
main proc

	invoke Uppercase,  character
	exit
main endp
end main
!
include Irvine32.inc
extern Uppercase@0:proc
Uperr equ Uppercase@0
.data
	character byte 'x'
.code
	main proc
		movzx ax, character
		push ax
		call uperr
		main endp
end main