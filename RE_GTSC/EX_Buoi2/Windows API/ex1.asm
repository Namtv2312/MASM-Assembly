; The edit.asm file
.586P
; Flat memory model
.MODEL FLAT, stdcall
include ex1.inc
; Directives for the linker to link libraries
includelib d:\masm32\lib\user32.lib
includelib d:\masm32\lib\kernel32.lib
;------------------------------------------
.data
	 NEWHWND DD 0
	 MSG MSGSTRUCT <?>
	 WC WNDCLASS <?>
	 HINST DD 0 ; Application descriptor
	 TITLENAME DB 'Application - Reverse String', 0
	 CLASSNAME DB 'CLASS32', 0
	 CPBUT DB 'Reverse', 0 ; Reverse
	 CPEDT DB ' ', 0
	 CPRET DB ' ', 0
	 CLSBUTN DB 'BUTTON', 0
	 CLSEDIT DB 'EDIT', 0
	 HWNDBTN DWORD 0
	 HWNDEDT DWORD 0
	 HWNDRET DWORD 0
	 CAP DB 'Message', 0
	 MES DB 'Quit Program', 0
	 TEXT DB 'Sample String to reverse',100 dup(0)
	 REV DB 500 DUP(?)
.code 
START:
	 PUSH 0                       ; Get the application descriptor
	 CALL GetModuleHandleA@4
	 MOV [HINST], EAX
	 REG_CLASS:
 ; Fill the window structure
; Style
	MOV [WC.CLSSTYLE], STYLE
; Message-handling procedure
	 MOV [WC.CLWNDPROC], OFFSET WNDPROC
	 MOV [WC.CLSCBCLSEX], 0
	 MOV [WC.CLSCBWNDEX], 0
	 MOV EAX, [HINST]
	 MOV [WC.CLSHINST], EAX
;----------Window icon
	 PUSH IDI_APPLICATION
	 PUSH 0
	 CALL LoadIconA@8
	 MOV [WC.CLSHICON], EAX
;---------- Window cursor
	 PUSH IDC_ARROW
	 PUSH 0
	 CALL LoadCursorA@8
	 MOV [WC.CLSHCURSOR], EAX
;----------
	 MOV [WC.CLBKGROUND],25  ; Window color
	 MOV DWORD PTR [WC.CLMENNAME], 0
	 MOV DWORD PTR [WC.CLNAME], OFFSET CLASSNAME
	 PUSH OFFSET WC
	 CALL RegisterClassA@4
; Create a window of the registered class
	 PUSH 0
	 PUSH [HINST]
	 PUSH 0
	 PUSH 0
	 PUSH 140 ; DY -- Window height
	 PUSH 655; DX -- Window width
	 PUSH 200 ; Y -- Coordinate of the top left corner
	 PUSH 200 ; X -- Coordinate of the top left corner
	 PUSH WS_OVERLAPPEDWINDOW
	 PUSH OFFSET TITLENAME ; Window title
	 PUSH OFFSET CLASSNAME ; Class name
	 PUSH 0
	 CALL CreateWindowExA@48
; Check for error
	 CMP EAX, 0
	 JZ _ERR
	 MOV [NEWHWND], EAX ; Window 'descriptor
;--------------------------------
	 PUSH SW_SHOWNORMAL
	 PUSH [NEWHWND]
	 CALL ShowWindow@8 ; Show newly-created window
;--------------------------------
	 PUSH [NEWHWND]
	 CALL UpdateWindow@4 ; Command to redraw the visible
 ; part of the window, the WM_PAINT message
; Message-handling loop
	MSG_LOOP:
	 PUSH 0
	 PUSH 0
	 PUSH 0
	 PUSH OFFSET MSG
	 CALL GetMessageA@16
	 CMP EAX, 0
	 JE END_LOOP
	 PUSH OFFSET MSG
	 CALL TranslateMessage@4
	 PUSH OFFSET MSG
	 CALL DispatchMessageA@4
	JMP MSG_LOOP
	END_LOOP:
	; Exit the program (close the process)
	 PUSH [MSG.MSWPARAM]
	 CALL ExitProcess@4
	_ERR:
	 JMP END_LOOP
;-------------------------------Window procedure
; Position of parameters in the stack
; [EBP+014H] ; LPARAM
; [EBP+10H] ; WAPARAM
; [EBP+0CH] ; MES
; [EBP+8] ; HWND
	WNDPROC PROC
		 PUSH EBP
		 MOV EBP, ESP
		 PUSH EBX
		 PUSH ESI
		 PUSH EDI
		 CMP DWORD PTR [EBP+0CH], WM_DESTROY
		 JE WMDESTROY
		 CMP DWORD PTR [EBP+0CH], WM_CREATE
		 JE WMCREATE
		 CMP DWORD PTR [EBP+0CH], WM_COMMAND
		 JE WMCOMMND
		 JMP DEFWNDPROC
		WMCOMMND:
		 MOV EAX, HWNDBTN
		 CMP DWORD PTR [EBP+14H], EAX
		 JNE NODESTROY
; Get the input string
		 PUSH OFFSET TEXT
		 PUSH 1000                                       ; limited character sending and output, (optional edit)
		 PUSH WM_GETTEXT
		 PUSH HWNDEDT
		 CALL SendMessageA@16
; init register
      MOV ESI ,OFFSET TEXT
	  MOV EDI ,OFFSET REV
	  MOV ECX ,EAX									;after SendMessageA@16 return, eax have value number byte buffer has
;Handle reverse string
Reverse_str:							;pseudo-code C is:
     CMP ECX,0              ;			i=0;length=strlen(text)-1
	 JE Final                 ;			while (length >0){temp = text[length];rev[i]=temp;i++;length--}
	 MOV AL,[ESI+ECX-1]
	 MOV [EDI],AL
	 INC EDI
	 DEC ECX
	 JMP Reverse_str
Final:									;add 0 to end of string rev
    MOV AL,0
	MOV [EDI],AL
	JMP Display_str
; Display the edited string
	 PUSH 0
	 PUSH OFFSET CAP
	 PUSH OFFSET TEXT
	 PUSH DWORD PTR [EBP+08H] ; Window descriptor
	; CALL MessageBoxA@16
; Exit
	JMP FINISH
	NODESTROY:
		 MOV EAX, 0
		 JMP FINISH
	WMCREATE:
; Create the edit window
		 PUSH 0
		 PUSH [HINST]
		 PUSH 0
		 PUSH DWORD PTR [EBP+08H]
		 PUSH 20 ; DY
		 PUSH 600 ; DX
		 PUSH 10 ; Y
		 PUSH 20 ; X
		 PUSH STYLEDT																; with edit control style , ES_AUTOHSCROLL, cuon theo input keyboard
		 PUSH OFFSET CPRET ; Window name
		 PUSH OFFSET CLSEDIT ; Class name
		 PUSH 0
		 CALL CreateWindowExA@48
		 MOV HWNDEDT, EAX    
;---------Place the string into the edit field
         PUSH OFFSET TEXT
         PUSH 0
         PUSH WM_SETTEXT
         PUSH HWNDEDT
         CALL SendMessageA@16
; Create the return window
		 PUSH 0
		 PUSH [HINST]
		 PUSH 0
		 PUSH DWORD PTR [EBP+08H]
		 PUSH 20 ; DY
		 PUSH 600 ; DX
		 PUSH 40 ; Y
		 PUSH 20 ; X
		 PUSH STYLRET																			;with es_readonly( edit control style)not edit field; ES_AUTOHSCROLL, cuon theo field
		 PUSH OFFSET CPEDT ; Window name
		 PUSH OFFSET CLSEDIT ; Class name
		 PUSH 0
		 CALL CreateWindowExA@48
		 MOV HWNDRET, EAX
;Create the button window
    PUSH 0
    PUSH [HINST] 
    PUSH 0
    PUSH DWORD PTR [EBP+08H]
    PUSH 25 ; DY
    PUSH 100 ; DX
    PUSH 70 ; Y
    PUSH 20 ; X
    PUSH STYLBTN
    PUSH OFFSET CPBUT ; Window name
    PUSH OFFSET CLSBUTN ; Class name
    PUSH 0
    CALL CreateWindowExA@48
    MOV HWNDBTN, EAX ; Save the button descriptors
;---------Set the focus to the edit window
	PUSH HWNDBTN
	CALL SetFocus@4
;---------Place the reverse string to the edit field 2
Display_str:
         PUSH OFFSET REV
         PUSH 0
         PUSH WM_SETTEXT
         PUSH HWNDRET
         CALL SendMessageA@16
;---------Print the reverse string
		 PUSH OFFSET REV
		 PUSH 150
		 PUSH WM_GETTEXT
		 PUSH HWNDRET
		 CALL SendMessageA@16

;----Finish the program
		 MOV EAX, 0
		 JMP FINISH
	DEFWNDPROC:
		 PUSH DWORD PTR [EBP+14H]
		 PUSH DWORD PTR [EBP+10H]
		 PUSH DWORD PTR [EBP+0CH]
		 PUSH DWORD PTR [EBP+08H]
		 CALL DefWindowProcA@16
		 JMP FINISH
	WMDESTROY:
		 PUSH 0 ; MB_OK
		 PUSH OFFSET CAP
		 PUSH OFFSET MES
		 PUSH DWORD PTR [EBP+08H] ; Window descriptor
		 CALL MessageBoxA@16
		 PUSH 0
		 CALL PostQuitMessage@4 ; WM_QUIT message
		 MOV EAX, 0
	FINISH:
		 POP EDI
		 POP ESI
		 POP EBX
		 POP EBP
		 RET 16
WNDPROC ENDP
END START