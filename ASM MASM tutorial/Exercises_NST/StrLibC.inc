
include Irvine32.inc
; Copy a source string to a target string.
Str_copyy PROTO,
 source:PTR BYTE,
 target:PTR BYTE
; Return the length of a string (excluding the null byte) in EAX.
Str_lengthh PROTO,
pString:PTR BYTE

; Compare string1 to string2. Set the Zero and
; Carry flags in the same way as the CMP instruction.
Str_comparee PROTO,
string1:PTR BYTE,
string2:PTR BYTE
; Trim a given trailing character from a string.
; The second argument is the character to trim.
Str_trimm PROTO,
pString:PTR BYTE,
char:BYTE
; Convert a string to upper case.
Str_ucasee PROTO,
pString:PTR BYTE