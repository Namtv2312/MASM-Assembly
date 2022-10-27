;define IDD_PASSWORD                    101
;define IDI_ICON1                       112
;define IDD_DIALOG1                     113
;define IDC_PASSWORD                    1000
;define IDC_BUTTON                      3001
;define ID_FILE_OPEN                    40001
;define ID_FILE_OPEN40002               40002
;define ID_FILE_CLOSE                   40003
;define ID_FILE_CLOSEALL                40004
;define ID_FILE_SAVE                    40005
;define ID_FILE_SAVEAS                  40006
;define ID_FILE_LOADCFFEXPLORERSCRIPT   40007
;define ID_FILE_EXIT                    40008
;define ID_SETTINGS_ENABLESHELLEXTENSIONS 40009
;define ID_SETTINGS_DISABLESHELLEXTENSIONS 40010
;define ID_SETTINGS_PREFERENCES         40011
;define ID__ABOUT                       40012;ALL infor in resource.h
;define IDOK                1
;define IDCANCEL            2
 ;Dialog Box Command IDs path : C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\um\winuser.rh

.386
.model flat, stdcall
include ex2.inc

.const
IDB_BITMAP1         equ            116
BN_CLICKED equ 0
IDC_EDIT equ 3000
IDCANCEL  equ          2
IDOK equ 1
ID__ABOUT equ 40012
ID_FILE_OPEN        equ            40001
ID_FILE_OPEN40002 equ 40002
ID_FILE_CLOSE equ 40003
ID_FILE_CLOSEALL equ 40004
ID_FILE_SAVE equ 40005
ID_FILE_SAVEAS equ 40006
ID_FILE_LOADCFFEXPLORERSCRIPT equ 40007
ID_FILE_EXIT equ 40008
ID_SETTINGS_ENABLESHELLEXTENSIONS equ 40009
ID_SETTINGS_DISABLESHELLEXTENSIONS equ 40010
ID_SETTINGS_PREFERENCES equ 40011
.data

ofn OPENFILENAME <?>
 HINST DD 0 ; Application descriptor
	 NEWHWND DD 0
	 MSG MSGSTRUCT <?>
	 WC WNDCLASS <?>
	 TITLENAME DB 'CFF Explorer VIII', 0
	 CLASSNAME DB 'CLASS32', 0
	 CPBUT DB 'Dos Header', 0 ; Reverse
	 CPEDT DB ' ', 0
	 CPRET DB ' ', 0
	 CLSBUTN DB 'BUTTON', 0
	 CLSEDIT DB 'EDIT', 0
	 HWNDBTN DWORD 0
	 HWNDEDT DWORD 0
	 HWNDRET DWORD 0
	 CAP DB 'Message', 0
	 MES DB 'Quit Program', 0
	 CLMENUNAME DB "MENUCFF",0
	 DlgName db "ABOUT_ME",0
	FilterString db "All Files",0,"*.*",0
     db "Text Files",0,"*.txt",0,0
	 icIcon db "IDI_ICON1",0
	buffer db 65535 dup(0)
	hMenu DWORD ?
	hDlg DWORD ?
	hFileRead DWORD  ?
	hMapFile DWORD 0
	hwndCsl DWORD ?
	hMemory DWORD ?
	pMemory DWORD ?
	SizeReadWrite DWORD ?
	TreeViewClass db "TreeView",0
	hwndTreeView	dd ?
	hParent		dd ?
	hImageList	dd ?
	hDragImageList		dd ?
	hBitmap dd ?
	tvinsert TV_INSERTSTRUCT <?>
	Parent		db "Parent Item",0
	Child1		db "child1",0
	Child2		db "child2",0
	tvhit TV_HITTESTINFO <>


.code
;label start entry point
Start:
	PUSH 0                   
	 CALL GetModuleHandleA@4

	 MOV [HINST], EAX
	 Call GetCommandLine

	 push STD_OUTPUT_HANDLE
	 call GetStdHandle
	 mov [hwndCsl], eax

	 call WinMain

	 push eax
	 call ExitProcess

WinMain proc
;fill winclass struct
	MOV [WC.CLSSTYLE], STYLE
	 MOV [WC.CLWNDPROC], OFFSET WNDPROC
	 MOV [WC.CLSCBCLSEX], 0
	 MOV [WC.CLSCBWNDEX], 0
	 PUSH [HINST]
	 POP [WC.CLSHINST]
	 MOV [WC.CLBKGROUND],25  ; Window color
	 MOV DWORD PTR [WC.CLMENNAME],  OFFSET CLMENUNAME
	 MOV DWORD PTR [WC.CLNAME], OFFSET CLASSNAME
; indicate cursor winclass
	 PUSH IDC_ARROW
	 PUSH 0
	 CALL LoadCursorA@8
	 MOV [WC.CLSHCURSOR], EAX
; indicate icon 
	 PUSH  OFFSET icIcon
	 PUSH 0
	 CALL LoadIconA@8
	 MOV [WC.CLSHICON], EAX
;register class
	 PUSH OFFSET WC
	 CALL RegisterClassA@4

;create windows 
	 PUSH 0
	 PUSH [HINST]
	 PUSH 0
	 PUSH 0
	 PUSH 600 ; DY -- Window height
	 PUSH 600; DX -- Window width
	 PUSH 200 ; Y -- Coordinate of the top left corner
	 PUSH 200 ; X -- Coordinate of the top left corner
	 PUSH 010CB0000h;WS_OVERLAPPEDWINDOW
	 PUSH OFFSET TITLENAME ; Window title
	 PUSH OFFSET CLASSNAME ; Class name
	 PUSH WS_EX_CLIENTEDGE
	 CALL CreateWindowExA@48

	 CMP EAX, 0
	 JZ _ERR
	 MOV [NEWHWND], EAX ; Window 'descriptor, cat vao EAX
; newhnd , handle for windows create recently
;	 PUSH SW_SHOWNORMAL
;	 PUSH [NEWHWND]
;	 CALL ShowWindow@8 ; Show newly-created window 

;	 PUSH [NEWHWND]
;	 CALL UpdateWindow@4 ; Command to redraw the visible
; getmesseage từ queue , dich ra WM etc , gui lai ve Window, to process message ( callback func, wndproc)
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

	 PUSH [MSG.MSWPARAM]
	 CALL ExitProcess@4
	_ERR:
	 JMP END_LOOP
WinMain endp

	WNDPROC PROC
		 PUSH EBP
		 MOV EBP, ESP
		 PUSH EBX
		 PUSH ESI
		 PUSH EDI
		 ;cmp uMsg with WM, if equal, jmp to label xử lý tương ứng; else jmp mặc định defwndproc
		 CMP DWORD PTR [EBP+0CH], WM_DESTROY
		 JE WMDESTROY
		 CMP DWORD PTR [EBP+0CH], WM_CREATE
		 JE WMCREATE
		 CMP DWORD PTR [EBP+0CH], WM_COMMAND
		 JE WMCOMMND
		 CMP DWORD PTR [EBP + 0CH],WM_MOUSEMOVE
		 JE WMMOUSEMOVE
		 CMP DWORD PTR [EBP+0CH], WM_LBUTTONUP
		 JE LBUTTONUP
		 CMP DWORD PTR [EBP+0CH], WM_NOTIFY
		 JE WMNOTIFY
		 JMP DEFWNDPROC
; bat cu nhung thay doi, action tren window, tu dong tao ra command message
WMCOMMND:

cmp dword ptr [EBP+010h], ID_FILE_OPEN
jz File_hnd
cmp dword ptr [EBP+010h], ID_FILE_OPEN40002
jz File_hnd
cmp dword ptr [EBP+010h], ID_FILE_EXIT
JZ WMDESTROY
cmp dword ptr [EBP+010h], ID__ABOUT
jz about_me
jmp finish

File_hnd:
mov [ofn.Flags], 0281804h
push offset ofn
call GetOpenFileName

push 0
push 020h
push 3
push 0
push 3
push 0C0000000h ; GENERIC READ/WRITE
push offset buffer
call CreateFileA

mov [hFileRead], eax
push 0
push 0
push 0
push PAGE_READONLY
push 0
push [hFileRead]
call CreateFileMapping

mov [hMapFile],eax
mov eax, OFFSET buffer
movzx edx, [ofn.nFileOffset]
add eax,edx

push eax
push [NEWHWND]
call SetWindowText

push 65535
push 42h
call GlobalAlloc

mov [hMemory], eax
push [hMemory]
call GlobalLock
mov [pMemory],eax

push 0
push offset SizeReadWrite
push 65534
push [pMemory]
push [hFileRead]
call ReadFile

push [pMemory]
push 0
push WM_SETTEXT
push [HWNDEDT]
CALL SendMessage

push [hFileRead]
call CloseHandle

push [pMemory]
call GlobalUnlock

push [hMemory]
call GlobalFree

push MF_GRAYED
push ID_FILE_CLOSEALL
push [hMenu]
call EnableMenuItem

; windows tree
push 0
push [HINST]
push 0
push dword ptr [EBP + 08h]
push 400
push 200
push 100
push 100
push 50000007h; style
push 0
push offset TreeViewClass
push 0
call CreateWindowExA

mov [hwndTreeView], eax
push 10
push 2
push ILC_COLOR16     
push 16
push 16
call ImageList_Create

mov [hImageList],eax
push IDB_BITMAP1
push [HINST]
call LoadBitmap

mov [hBitmap],eax
push 0
push [hBitmap]
push [hImageList]
call ImageList_Add

push [hBitmap]
call DeleteObject

push [hImageList]
push 0
push TVM_SETIMAGELIST
push [hwndTreeView]
call SendMessage

mov tvinsert.hParent, 0
mov tvinsert.hInsertAfter,0FFFF0000h;TVI_ROOT
mov tvinsert.item.imask,23h;TVIF_TEXT+TVIF_IMAGE+TVIF_SELECTEDIMAGE
mov tvinsert.item.pszText,offset Parent
mov tvinsert.item.iImage,0
mov tvinsert.item.iSelectedImage,1

push offset tvinsert
push 0
push TVM_INSERTITEM
push [hwndTreeView]
call SendMessage

MOV [hParent], eax
mov tvinsert.hParent,eax
mov tvinsert.hInsertAfter,0FFFF0002h;TVI_LAST
mov tvinsert.item.pszText,offset Child1

push offset tvinsert
push 0
push TVM_INSERTITEM
push [hwndTreeView]
call SendMessage

mov tvinsert.item.pszText,offset Child2
push offset tvinsert
push 0
push TVM_INSERTITEM
push [hwndTreeView]
call SendMessage
jmp finish

WMMOUSEMOVE:
	mov eax, dword ptr [ebp+014h]
	and eax, 0ffffh
	mov ecx, dword ptr [ebp+014h]
	shr ecx, 16
	mov tvhit.pt.x, eax
	mov tvhit.pt.y,ecx
	push ecx
	push eax
	call ImageList_DragMove

	PUSH 0
	CALL ImageList_DragShowNolock

	push offset tvhit
	push 0
	push TVM_HITTEST
	push [hwndTreeView]
	call SendMessage

	cmp eax,0
	jz flg
	push 1
	call ImageList_DragShowNolock
flg:
	push eax
	push TVGN_DROPHILITE
	push TVM_SELECTITEM
	push [hwndTreeView]
	call SendMessage

LBUTTONUP:
push [hwndTreeView]
call ImageList_DragLeave

call ImageList_EndDrag

push [hDragImageList]
call ImageList_Destroy

push 0
push TVGN_DROPHILITE
PUSH TVM_GETNEXTITEM
push [hwndTreeView]
call SendMessage

push eax
push TVGN_CARET
push TVM_SELECTITEM
push [hwndTreeView]
call SendMessage

push 0
push TVGN_DROPHILITE
push TVM_SELECTITEM
push [hwndTreeView]
call SendMessage

call ReleaseCapture
jmp finish
WMNOTIFY:
mov edi, dword ptr [014h]
cmp dword ptr[edi+8],0FFFFFE69h;TVN_BEGINDRAG
jnz finish
push dword ptr [edi+3ch]
push 0
push 1112h
push [hwndTreeView]
call SendMessage

push 0
push 0
push 0
push [hDragImageList]
call ImageList_BeginDrag

push dword ptr [edi+64h]
push dword ptr [edi+60h]
push [hwndTreeView]
call ImageList_DragEnter

push dword ptr [ebp+08h]
call SetCapture
	jmp finish

;push 0
;push 4
;push 2
;push eax
;push [hwndCsl]
;call WriteConsoleA
;jmp finish

about_me:
		 push 0
		 push 0
		 push 0
		 push offset DlgName
		 push [HINST]
		 CALL DialogBoxParamA
		 mov [hDlg], eax

		 push IDC_EDIT
		 push [hDlg]
		 call GetDlgItem

		 push eax
		 call SetFocus

		 push SW_SHOWNORMAL
		 push [hDlg]
		 call ShowWindow@8

		 push [hDlg]
		 call UpdateWindow
		
		mov edx, dword ptr [ebp+010h]
		shr edx, 16
		cmp dx, BN_CLICKED
		jnz finish
		cmp ax, IDCANCEL
		jz WMDESTROY
		cmp ax, IDOK
		jz WMDESTROY
mov eax, 0
JMP FINISH

	NODESTROY:
		 MOV EAX, 0
		 JMP FINISH
; bat cu windows duoc tao ra, sẽ có wmcreate message, label xu ly messeage này
	WMCREATE:
		push [NEWHWND]
		call GetMenu
		mov [hMenu],eax

;fill openfilename structure
		mov [ofn.lStructSize],SIZEOF ofn
		push [NEWHWND]
		pop [ofn.hWndOwner]
		PUSH [HINST]
		pop [ofn.hInstance]
		mov  [ofn.lpstrFilter], OFFSET FilterString
		mov  [ofn.lpstrFile], OFFSET buffer
		mov  [ofn.nMaxFile],65535

		 PUSH 0
		 PUSH [HINST]
		 PUSH 0
		 PUSH DWORD PTR [EBP+08H]
		 PUSH 100 ; DY
		 PUSH 100 ; DX
		 PUSH 10 ; Y
		 PUSH 100 ; X
		 PUSH 500000C4h; WS_VISIBLE or WS_CHILD or ES_LEFT or ES_MULTILINE or ES_AUTOHSCROLL or ES_AUTOVSCROLL
		 PUSH OFFSET CPRET ; Window name
		 PUSH OFFSET CLSEDIT ; Class name
		 PUSH 0
		 CALL CreateWindowExA@48
		 MOV HWNDEDT, EAX    
		 ;---------Set the focus to the edit window
	PUSH HWNDEDT
	CALL SetFocus@4

push 0
push [HINST]
push 0
push dword ptr [EBP + 08h]
push 400
push 200
push 100
push 100
push 50000007h; style
push 0
push offset TreeViewClass
push 0
call CreateWindowExA

mov [hwndTreeView], eax
push 10
push 2
push ILC_COLOR16     
push 16
push 16
call ImageList_Create

mov [hImageList],eax
push IDB_BITMAP1
push [HINST]
call LoadBitmap

mov [hBitmap],eax
push 0
push [hBitmap]
push [hImageList]
call ImageList_Add

push [hBitmap]
call DeleteObject

push [hImageList]
push 0
push TVM_SETIMAGELIST
push [hwndTreeView]
call SendMessage

mov tvinsert.hParent, 0
mov tvinsert.hInsertAfter,0FFFF0000h;TVI_ROOT
mov tvinsert.item.imask,23h;TVIF_TEXT+TVIF_IMAGE+TVIF_SELECTEDIMAGE
mov tvinsert.item.pszText,offset Parent
mov tvinsert.item.iImage,0
mov tvinsert.item.iSelectedImage,1

push offset tvinsert
push 0
push TVM_INSERTITEM
push [hwndTreeView]
call SendMessage

MOV [hParent], eax
mov tvinsert.hParent,eax
mov tvinsert.hInsertAfter,0FFFF0002h;TVI_LAST
mov tvinsert.item.pszText,offset Child1

push offset tvinsert
push 0
push TVM_INSERTITEM
push [hwndTreeView]
call SendMessage

mov tvinsert.item.pszText,offset Child2
push offset tvinsert
push 0
push TVM_INSERTITEM
push [hwndTreeView]
call SendMessage


    PUSH 0
    PUSH [HINST] 
    PUSH 0
    PUSH DWORD PTR [EBP+08H]
    PUSH 25 ; DY
    PUSH 100 ; DX
    PUSH 400 ; Y
    PUSH  20; X
    PUSH STYLBTN
    PUSH OFFSET CPBUT ; Window name
    PUSH OFFSET CLSBUTN ; Class name
    PUSH 0
    CALL CreateWindowExA@48
    MOV HWNDBTN, EAX ; Save the button descriptors

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

	FINISH:
		
		 POP EDI
		 POP ESI
		 POP EBX
		 POP EBP
		 RET 16
WNDPROC ENDP

End Start