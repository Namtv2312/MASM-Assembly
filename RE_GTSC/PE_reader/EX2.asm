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
IDB_BITMAP1           equ          115
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


	DOS_HEADER IMAGE_DOS_HEADER <?>
DOS_HEADER_LINE DB "DOS HEADER",0
NT_HEADER_LINE db "NT HEADER",0
NUMB DWORD ?
NUMW DWORD ?
fsize dword ?
CRLF DB 13,10,0
DOS_HEADER_BUFER DB 65535 DUP(?)
FIRST_LINE DB "Member    |   OFFSET    |    Size    |  Value ",0
CV DB 128 DUP(?)
WCOL DB   "     |    WORD    |  ",0
DWCOL DB  "     |    DWORD   |  ",0
BCOL DB  "     |    Byte    |  ",0
E_MAGIC DB    "e_magic   |",0
E_CBLP  DB    "e_cblp    |",0
E_CP    DB    "e_cp      |",0
E_CRLC  DB    "e_crlc    |",0
E_CPARHDR DB  "e_cparhdr |",0
E_MINALLOC DB "e_minalloc|",0
E_MAXALLOC DB "e_maxalloc|",0
E_SS DB       "e_ss      |",0
E_SP DB       "e_sp      |",0
E_CSUM DB     "e_csum    |",0
E_IP DB       "e_ip      |",0
E_CS DB       "e_cs      |",0
E_LFARLC DB     "e_lfarlc  |",0
E_OVNO     DB   "e_ovno    |",0
E_RES      DB   "e_res     |",0
E_OEMID    DB   "e_oemid   |",0
E_OEMINFO  DB   "e_oeminfo |",0
E_RES2     DB   "e_res2    |",0
E_LFANEW   DB   "e_lfanew  |",0
none db "          |",0
line_bre db "<------------------------------------->",0
Offset_dos dword 0
Offset_nt dword 0
form db "%08lx",0
buf db 0
	db 100 dup(0)
tmp_store_hex db 100 dup(?),0
Signature db "Signature |",0
File_Header db "File Header",0
f_header DB "Member              |   OFFSET    |    Size    |  Value   | Meaning ",0
machine db "Machine             |",0
nbOfStion db "NumberOfSections    |",0
tDStamp db "TimeDateStamp	    |",0
PtSymTble db "PointerToSymbolTable|",0
nbOfSymbols db "NumberOfSymbols	    |",0
szOfOpHder db "SizeOfOptionalHeader|",0
chteristic db "Characteristics     |",0
; type machine
IMAGE_FILE_MACHINE_AM33 dw 01d3h
						db "|am33",0
						
IMAGE_FILE_MACHINE_UNKNOWN dw 0
							db "|Unknow",0
IMAGE_FILE_MACHINE_AMD64 dw 08664h
							db "|AMD64",0
IMAGE_FILE_MACHINE_ARM dw 01c0h
					db "|ARM",0
IMAGE_FILE_MACHINE_ARM64 dw 0aa64h
					db "|ARM64",0
IMAGE_FILE_MACHINE_ARMNT dw 01c4h
					db "|ARMNT",0
IMAGE_FILE_MACHINE_EBC dw 0ebch
						db "|EBC",0
IMAGE_FILE_MACHINE_I386 dw 014ch
						db "|I386",0
IMAGE_FILE_MACHINE_IA64 dw 0200h
						db "|IA64",0
IMAGE_FILE_MACHINE_LOONGARCH32 dw 06232h
								db "|LOONGARCH32",0
IMAGE_FILE_MACHINE_LOONGARCH64 dw 6264h		
								db "|LOONGARCH64",0
IMAGE_FILE_MACHINE_M32R dw 9041h
							db "|M32R",0
IMAGE_FILE_MACHINE_MIPS16 dw 266h	
							DB "|MIPS16",0
IMAGE_FILE_MACHINE_MIPSFPU  dw 366h
							db "|MIPSFPU",0
IMAGE_FILE_MACHINE_MIPSFPU16  dw 466h
							db "|MIPSFPU16",0
IMAGE_FILE_MACHINE_POWERPC dw 1f0h
							DB "|POWERPC",0
IMAGE_FILE_MACHINE_POWERPCFP dw 1f1h
							db "|POWERPCFP",0
IMAGE_FILE_MACHINE_R4000 dw 166h	
							db "|R4000",0
IMAGE_FILE_MACHINE_RISCV32 dw 5032h
							db "|RISCV32",0
IMAGE_FILE_MACHINE_RISCV64 dw 5064h
							db "|RISCV64",0
IMAGE_FILE_MACHINE_RISCV128 dw 5128h
							db "|RISCV128",0
IMAGE_FILE_MACHINE_SH3 dw 1a2h
						db "|SH3",0
IMAGE_FILE_MACHINE_SH3DSP dw 1a3h
						db "|SH3DSP",0
IMAGE_FILE_MACHINE_SH4 dw 1a6h
						db "|SH4",0
IMAGE_FILE_MACHINE_SH5 dw 1a8h
						DB "|SH5",0
IMAGE_FILE_MACHINE_THUMB dw 1c2h
							db "|thumb",0
IMAGE_FILE_MACHINE_WCEMIPSV2 dw 169h
						DB "|WCEMIPSV2",0

;optional Header 
pe32 DW 010bh
	db "|PE32",0
pe64 dw   020bh
	db "|PE64",0
rom dw	0107h
	db "|ROM",0
;subsystem
IMAGE_SUBSYSTEM_UNKNOWN dw 0
						db "Unknown value",0
IMAGE_SUBSYSTEM_NATIVE dw 1
						db "Native",0
IMAGE_SUBSYSTEM_WINDOWS_GUI	  dw 2
			db "|WINDOWS GUI",0
IMAGE_SUBSYSTEM_WINDOWS_CUI		   dw  3
	db "Windows Cui",0
IMAGE_SUBSYSTEM_OS2_CUI	  dw 5
	db "OS/2 Console",0
IMAGE_SUBSYSTEM_POSIX_CUI  dw 7
db "Posix Console",0
IMAGE_SUBSYSTEM_NATIVE_WINDOWS		   dw 8
db "Native Windows",0
IMAGE_SUBSYSTEM_WINDOWS_CE_GUI		 dw 9
db "WinCE",0
IMAGE_SUBSYSTEM_EFI_APPLICATION	  dw 10
	db "EFI Application",0
IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER   dw 11
db "EFI Boot Driver",0
IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER		 dw 12
db "EFI Runtime Driver",0
IMAGE_SUBSYSTEM_EFI_ROM		  dw 13
db "EFI Rom",0
IMAGE_SUBSYSTEM_XBOX   dw 14
db "XBox",0
IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION  dw 16
db "Windows Boot Application",0
opthder db "Optional Header"   ,0
o_header DB "Member                     |   OFFSET    |    Size    |  Value   | Meaning ",0
magic db "Magic			   |",0
majLinkVersion db "MajorLinkerVersion         |",0
minorLnkV db "MinorLinkerVersion         |",0
SofCode db "Size Of Code               |",0
SOfInitDat db "SizeOfInitData             |",0
SOfUninDat db "SizeOfUninitializedData    |",0
AddOfEnP db "AddressOfEntryPoint        |",0
BOfCode db "BaseOfCode                 |",0
BOfDat db "BaseOfData                 |",0
imgB db "ImageBase                  |",0
SecAlign db "SectionAlignment           |",0
FileAlign db "FileAlignment              |",0
MajOperSys		   db "MajorOperatingSystemVersion|",0
MinorOperSys db "MinorOperatingSystemVersion|",0
MajImV db "MajorImageVersion          |",0
MinImgVersion db "MinorImageVersion          |",0
MajSubVer db "MajorSubsystemVersion      |",0
MinSubVer db "MinorSubsystemVersion      |",0
WinVerVal db "Win32VersionValue          |",0
SOfImg db "SizeOfImage                |",0
SOfHeader db "SizeOfHeader               |",0
ChkSum db "CheckSum                   |",0
Subs db "Subsystem                  |",0
DLLchar db "DllCharacteristics         |",0
SOfStackRes db "SizeOfStackReserve         |",0
SOfStackCom db "SizeOfStackCommit          |",0
SOfHeapRes db "SizeOfHeapReserve          |",0
SOfHeapCom db "SizeOfHeapCommit           |",0
LoadFl db "LoaderFlags                |",0
numOfRvaASize db "NumberOfRvaAndSizes        |",0

;data dir 
dat_dir db "Data Directories",0
dat_dir_header DB "Member                             |   OFFSET    |    Size    |  Value   | Section ",0
ExpDirRVA db "Export Directory RVA		   |",0
ExpDirSize db "Export Directory Size	           |",0
ImDirRVA db "Import Directory RVA		   |",0
ImDirSize db "Import Directory Size		   |",0
ResDirRVA db "Resource Directory RVA		   |",0
ResDirSize db "Resource Directory Size		   |",0
ExcDirRVA db "Exception Directory RVA		   |",0
ExcDirSize db "Exception Directory Size	   |",0
SecDirRVA db "Security Directory RVA		   |",0
SecDirSize db "Security Directory Size		   |",0
RelDirRVA db "Relocation Directory RVA	   |",0
RelDirSize db "Relocation Directory Size	   |",0
DebDirSize db "Debug Directory Size		   |",0
DebDirRVA db "Debug Directory RVA	           |",0
archdirRVA db "Architecture Directory	RVA	   |",0
archdirSize db "Architecture Directory Size	   |",0
reserved db "Reseved				   |",0
tlsDirRVA db "TLS Directory RVA		   |",0
tlsDirSize db "TLS Directory Size		   |",0
confDirRVA db "Configuration Directory RVA	   |",0
confDirSize db "Configuration Directory Size	   |",0
bouImDirRVA db "Bound Import Directory RVA	   |",0
bouImDirSize db "Bound Import Directory Size	   |",0
ImAddTabDirRVA db "Import Address Table Directory RVA |",0
ImAddTabDirSize db "Import Address Table Directory Size|",0
DelImDirRVA db "Delay Import Directory RVA	   |",0
DelImDirSize db "Delay Import Directory Size	   |",0
meldatRVA db ".NET MetaData Directory RVA        |",0
meldatSize db ".NET MetaData Directory Size       |",0
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

	 call InitCommonControls

WinMain proc
;fill winclass struct
	MOV [WC.CLSSTYLE], STYLE
	 MOV [WC.CLWNDPROC], OFFSET WNDPROC
	 MOV [WC.CLSCBCLSEX], 0
	 MOV [WC.CLSCBWNDEX], 0
	 PUSH [HINST]
	 POP [WC.CLSHINST]
	 MOV [WC.CLBKGROUND],12  ; Window color
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
;file map and open file
File_hnd:
mov [ofn.Flags], 0281804h   ;OFN_LONGNAMES or OFN_EXPLORER or OFN_HIDEREADONLY
push offset ofn
call GetOpenFileName

push 0
push 020h	 ;FILE_ATTRIBUTE_ARCHIVE
push 3		;OPEN_EXISTING
push 0
push 3
push 0C0000000h ; GENERIC READ/WRITE
push offset buffer
call CreateFileA
;cat file handle
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
;  start open file
;push 65535 ;GMEM_MOVEABLE or GMEM_ZEROINIT,MEMSIZE
;push 42h
;call GlobalAlloc

;mov [hMemory], eax
;push [hMemory]
;call GlobalLock

;mov [pMemory],eax

;push 0
;push offset SizeReadWrite
;push 65534
;push [pMemory]
;push [hFileRead]
;call ReadFile

;push dword ptr [pMemory]
;push 0
;push WM_SETTEXT
;push [HWNDEDT]
;CALL SendMessage

; end hnd file 

;push [hFileRead]
;call CloseHandle

;push [pMemory]
;call GlobalUnlock

;push [hMemory]
;call GlobalFree

;end read file
;push MF_GRAYED
;push ID_FILE_CLOSEALL
;push [hMenu]
;call EnableMenuItem
;end file map



push fsize
push [hFileRead]
call GetFileSize
or eax, fsize
mov fsize, eax

push 0
push 0
push 0
push 4; FILEMAPREAD
push [hMapFile]
call MapViewOfFile





















































;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PUSH 0
 PUSH OFFSET NUMB
 PUSH 65535
 PUSH OFFSET DOS_HEADER_BUFER
 PUSH [hFileRead]
 CALL ReadFile@20

 push [hFileRead]
 call CloseHandle


;STRING LENGTH
PUSH OFFSET DOS_HEADER_LINE
CALL LENSTR
;DOS_HEADER_LINE
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET DOS_HEADER_LINE
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
;XUONG DONG
 PUSH 0
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
;FIRST_LINE
PUSH OFFSET FIRST_LINE
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET FIRST_LINE
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20


;--------------e_magic--------------------------- 
push offset E_MAGIC
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut


PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ax, word ptr [DOS_HEADER_BUFER+0]
cmp eax, 00005a4dh
jnz about_me
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
 ;;;
 add offset_dos,2
 push offset E_CBLP  
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_CP      
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_CRLC    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

 

  add offset_dos,2
 push offset E_CPARHDR   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20


  add offset_dos,2
 push offset E_MINALLOC   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_MAXALLOC   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_SS   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_SP   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_CSUM   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_IP   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_CS   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_LFARLC   
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_OVNO       
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_RES        
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_OEMID      
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_OEMINFO    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

  add offset_dos,2
 push offset E_RES2       
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
   add offset_dos,2
 push offset none    
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

   add offset_dos,2
 push offset E_LFANEW          
call StdOut

push offset_dos
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

PUSH OFFSET WCOL
CALL LENSTR
 PUSH 0
 PUSH OFFSET NUMW
 PUSH EBX
 PUSH OFFSET WCOL
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

 ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20


 ;;;;;;;;;;NT header
 push offset line_bre
 call StdOut

 push offset NT_HEADER_LINE
 call StdOut
  ;XUONG DONG
 PUSH 0 
 PUSH OFFSET NUMW
 PUSH 2
 PUSH OFFSET CRLF
 PUSH [hwndCsl]
 CALL WriteConsoleA@20

 push offset FIRST_LINE
 call StdOut

  PUSH OFFSET CRLF
  call StdOut
 push offset Signature
 call StdOut

mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL 
call StdOut

mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
xor ebx,ebx
mov bx, ax
mov eax, dword ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset line_bre
call StdOut
push offset File_Header
call StdOut
push offset CRLF
call StdOut

push offset f_header
call StdOut

push offset CRLF
call StdOut
;FILEheader
push offset machine
call StdOut
xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
add ax,4
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut


xor eax, eax
mov ebx, offset_dos
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
mov Offset_nt, eax
add Offset_nt,4
mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
mov numb, eax
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
cmp ax, 	word ptr IMAGE_FILE_MACHINE_I386
jz  _I386
cmp ax, 	word ptr IMAGE_FILE_MACHINE_AM33
jz _AM33
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_UNKNOWN
jz _UNKNOW
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_AMD64
jz _AMD64
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_ARM
jz _ARM
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_ARM64
jz _ARM64
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_ARMNT
jz _ARMNT
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_EBC
jz _EBC
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_IA64
jz _IA64
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_LOONGARCH32
jz _LOONGARCH32
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_LOONGARCH64
jz _LOONGARCH64
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_M32R
jz _M32R
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_MIPS16
jz _MIPS16
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_MIPSFPU
jz _MIPSFPU
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_MIPSFPU16
jz _MIPSFPU16
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_POWERPC
jz _POWERPC
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_POWERPCFP
jz _POWERPCFP
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_RISCV32
jz _RISCV32
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_RISCV64
jz _RISCV64
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_RISCV128
jz _RISCV128
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_SH3
jz _SH3
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_SH3DSP
jz _SH3DSP
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_SH4
jz _SH4
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_SH5
jz _SH5
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_THUMB
jz _THUMB
cmp ax, word ptr 	  IMAGE_FILE_MACHINE_WCEMIPSV2
jz _WCEMIPSV2

_AM33:
push  offset  [IMAGE_FILE_MACHINE_AM33+2]
jmp outp
_UNKNOW:
push  offset  [IMAGE_FILE_MACHINE_UNKNOWN+2]
jmp outp
_I386:
push  offset  [IMAGE_FILE_MACHINE_I386+2]
jmp outp
_AMD64:
push  offset  [IMAGE_FILE_MACHINE_AMD64+2]
jmp outp
_ARM:
push  offset  [IMAGE_FILE_MACHINE_ARM+2]
jmp outp
_ARM64:
push  offset  [IMAGE_FILE_MACHINE_ARM64+2]
jmp outp
_ARMNT:
push  offset  [IMAGE_FILE_MACHINE_ARMNT+2]
jmp outp
_EBC:
push  offset  [IMAGE_FILE_MACHINE_EBC+2]
jmp outp
_IA64:
push  offset  [IMAGE_FILE_MACHINE_IA64+2]
jmp outp
_LOONGARCH32:
push  offset  [IMAGE_FILE_MACHINE_LOONGARCH32+2]
JMP outp
_LOONGARCH64:
push  offset  [IMAGE_FILE_MACHINE_LOONGARCH64+2]
jmp outp
_M32R:
push  offset  [IMAGE_FILE_MACHINE_M32R+2]
JMP outp
_MIPS16:
push  offset  [IMAGE_FILE_MACHINE_MIPS16+2]
jmp outp
_MIPSFPU:
push  offset  [IMAGE_FILE_MACHINE_MIPSFPU+2]
jmp outp
_MIPSFPU16:
push  offset  [IMAGE_FILE_MACHINE_MIPSFPU16+2]
jmp outp
_POWERPC:
push  offset  [IMAGE_FILE_MACHINE_POWERPC+2]
jmp outp
_POWERPCFP:
push  offset  [IMAGE_FILE_MACHINE_POWERPCFP+2]
jmp outp
_R4000:
push  offset  [IMAGE_FILE_MACHINE_R4000+2]
jmp outp
_RISCV32:
push  offset  [IMAGE_FILE_MACHINE_RISCV32+2]
jmp outp
_RISCV64:
push  offset  [IMAGE_FILE_MACHINE_RISCV64+2]
jmp outp
_RISCV128:
push  offset  [IMAGE_FILE_MACHINE_RISCV128+2]
jmp outp
_SH3:
push  offset  [IMAGE_FILE_MACHINE_SH3+2]
jmp outp
_SH3DSP:
push  offset  [IMAGE_FILE_MACHINE_SH3DSP+2]
jmp outp
_SH4:
push  offset  [IMAGE_FILE_MACHINE_SH4+2]
jmp outp
_SH5:
push  offset  [IMAGE_FILE_MACHINE_SH5+2]
jmp outp
_THUMB:
push  offset  [IMAGE_FILE_MACHINE_THUMB+2]
JMP outp
_WCEMIPSV2:
push  offset  [IMAGE_FILE_MACHINE_WCEMIPSV2+2]
outp:
call StdOut


push offset CRLF
call StdOut

push offset nbOfStion
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
mov numb, eax
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut


push offset CRLF
call StdOut

push offset tDStamp
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset PtSymTble
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut



push offset nbOfSymbols
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut


push offset CRLF
call StdOut

push offset szOfOpHder
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut


push offset chteristic
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut
push offset CRLF
call StdOut


push offset line_bre
call StdOut

push offset opthder
call StdOut

push offset CRLF
call StdOut

push offset o_header
call StdOut

push offset CRLF
call StdOut

push offset magic
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut
;meaning

xor eax, eax
mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
cmp ax, word ptr pe32
jz _pe32
cmp ax, word ptr pe64
jz _pe64
cmp ax, word ptr rom
jz _rom
_pe32:
push offset [pe32+2]
jmp outpp
_pe64:
push offset [pe64+2]
jmp outpp
_rom:
push offset [rom+2]
outpp:
call StdOut

push offset CRLF
call StdOut

push offset				 majLinkVersion
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset BCOL
call StdOut
xor eax, eax
mov ebx, Offset_nt
mov al, byte ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset minorLnkV
call StdOut

add Offset_nt,1
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF 
call StdOut

push offset  SofCode
call StdOut

add Offset_nt,1
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset 	SOfInitDat
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset   SOfUninDat
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  AddOfEnP
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  BOfCode
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  BOfDat
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF 
call StdOut

push offset  imgB
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SecAlign
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  FileAlign
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  MajOperSys
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax,word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  MinorOperSys
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax,word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  MajImV
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax,word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  MinImgVersion
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax,word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  MajSubVer
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax,word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  MinSubVer
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax,word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  WinVerVal
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SOfImg
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SOfHeader
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ChkSum
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  Subs
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax,word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax, word ptr [DOS_HEADER_BUFER+ebx]
cmp ax, word ptr IMAGE_SUBSYSTEM_UNKNOWN
jz _SUBSYSTEM_UNKNOWN
cmp ax, word ptr IMAGE_SUBSYSTEM_NATIVE
jz _SUBSYSTEM_NATIVE
cmp ax, word ptr IMAGE_SUBSYSTEM_WINDOWS_GUI
jz _WINDOWS_GUI
cmp ax, word ptr IMAGE_SUBSYSTEM_OS2_CUI
jz _SUBSYSTEM_OS2_CUI
cmp ax, word ptr IMAGE_SUBSYSTEM_POSIX_CUI
jz _SUBSYSTEM_POSIX_CUI
cmp ax, word ptr IMAGE_SUBSYSTEM_NATIVE_WINDOWS
jz _NATIVE_WINDOWS
cmp ax, word ptr IMAGE_SUBSYSTEM_WINDOWS_CE_GUI
jz _WINDOWS_CE_GUI
cmp ax, word ptr IMAGE_SUBSYSTEM_EFI_APPLICATION
jz _EFI_APPLICATION
cmp ax, word ptr IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER
jz _SERVICE_DRIVER
cmp ax, word ptr IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER
jz _RUNTIME_DRIVER
cmp ax, word ptr IMAGE_SUBSYSTEM_EFI_ROM
jz _EFI_ROM
cmp ax, word ptr IMAGE_SUBSYSTEM_XBOX
jz _XBOX
cmp ax, word ptr IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION
jz _BOOT_APPLICATION

_SUBSYSTEM_UNKNOWN:
push offset [IMAGE_SUBSYSTEM_UNKNOWN+2]
jmp outppp
_SUBSYSTEM_NATIVE:
push offset [IMAGE_SUBSYSTEM_NATIVE+2]
jmp outppp
_WINDOWS_GUI:
push offset [IMAGE_SUBSYSTEM_WINDOWS_GUI+2]
jmp outppp
_SUBSYSTEM_OS2_CUI:
push offset [IMAGE_SUBSYSTEM_OS2_CUI+2]
jmp outppp
_SUBSYSTEM_POSIX_CUI:
push offset [IMAGE_SUBSYSTEM_POSIX_CUI+2]
jmp outppp
_NATIVE_WINDOWS:
push offset [IMAGE_SUBSYSTEM_NATIVE_WINDOWS+2]
jmp outppp
_WINDOWS_CE_GUI:
push offset [IMAGE_SUBSYSTEM_WINDOWS_CE_GUI+2]
jmp outppp
_EFI_APPLICATION:
push offset [IMAGE_SUBSYSTEM_EFI_APPLICATION+2]
jmp outppp
_SERVICE_DRIVER:
push offset [IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER+2]
jmp outppp
_RUNTIME_DRIVER:
push offset [IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER+2]
jmp outppp
_EFI_ROM:
push offset [IMAGE_SUBSYSTEM_EFI_ROM+2]
jmp outppp
_XBOX:
push offset [IMAGE_SUBSYSTEM_XBOX+2]
jmp outppp
_BOOT_APPLICATION:
push offset [IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION+2]
jmp outppp

outppp:
call StdOut

push offset CRLF
call StdOut

push offset  DLLchar
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset WCOL
call StdOut

xor eax, eax
mov ebx, Offset_nt
mov ax,word ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SOfStackRes
call StdOut

add Offset_nt,2
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut

mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push eax
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SOfStackCom
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SOfHeapRes
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SOfHeapCom
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  LoadFl
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  numOfRvaASize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut
;data Directory
 push offset CRLF
 call StdOut
 
 push offset line_bre
 call StdOut

 push offset dat_dir
 call StdOut

 push offset CRLF
 call StdOut

 push offset dat_dir_header
 call StdOut

 push offset CRLF
call StdOut

push offset  ExpDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ExpDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ImDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ImDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ResDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ResDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ExcDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ExcDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SecDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  SecDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  RelDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  RelDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  DebDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  DebDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  archdirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  archdirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  reserved
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  reserved
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  tlsDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  tlsDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  confDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  confDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  bouImDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  bouImDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ImAddTabDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  ImAddTabDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  DelImDirRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  DelImDirSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  meldatRVA
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset CRLF
call StdOut

push offset  meldatSize
call StdOut

add Offset_nt,4
push Offset_nt
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut

push offset DWCOL
call StdOut


mov ebx, Offset_nt
push dword ptr [DOS_HEADER_BUFER+ebx]
push offset form
push offset buf
call wsprintfA

lea eax, buf
push eax
call StdOut
;----------------------------------------------------------------------------------------------
; End of program
NO_PAR:
 PUSH 0
 CALL ExitProcess@4
 WRITE PROC
; Get the parameter length
 PUSH EAX
 PUSH EAX
 CALL lstrlenA@4
 MOV ESI, EAX
 POP EBX
; String output
 PUSH 0
 PUSH OFFSET NUMB
 PUSH EAX
 PUSH EBX
 PUSH [hwndCsl]
 CALL WriteConsoleA@20
 RET
WRITE ENDP













































































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
call LoadBitmapA

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

push DWORD PTR [EBP+08H]
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

		 PUSH 0
		 PUSH [HINST]
		 PUSH 0
		 PUSH DWORD PTR [EBP+08H]
		 PUSH 300 ; DY
		 PUSH 300 ; DX
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
;fill openfilename structure
		mov [ofn.lStructSize],SIZEOF ofn
		push DWORD PTR [EBP+08H]
		pop [ofn.hWndOwner]
		PUSH [HINST]
		pop [ofn.hInstance]
		mov  [ofn.lpstrFilter], OFFSET FilterString
		mov  [ofn.lpstrFile], OFFSET buffer
		mov  [ofn.nMaxFile],65535


push 0
push [HINST]
push 0
push  dword ptr [ebp+8]
push 100
push 100
push 10
push 10
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