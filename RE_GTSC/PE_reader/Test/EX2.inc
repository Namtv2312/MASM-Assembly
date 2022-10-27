include d:\masm32\include\user32.inc
include D:\masm32\include\kernel32.inc
includelib D:\masm32\lib\user32.lib
includelib D:\masm32\lib\kernel32.lib
include D:\masm32\include\comctl32.inc
includelib D:\masm32\lib\comctl32.lib
include D:\masm32\include\gdi32.inc
includelib D:\masm32\lib\gdi32.lib
include D:\masm32\include\comdlg32.inc
includelib D:\masm32\lib\comdlg32.lib
;
NULL EQU 0
TVM_INSERTITEMA equ TV_FIRST + 0
TVM_INSERTITEMW equ TV_FIRST + 50
IFDEF __UNICODE__
    TVM_INSERTITEM equ TVM_INSERTITEMW
ELSE
    TVM_INSERTITEM equ TVM_INSERTITEMA
ENDIF
TV_FIRST            equ 1100h
TVM_SETIMAGELIST                equ TV_FIRST + 9
ILC_COLOR16      equ 0010h
WM_SETFOCUS equ 7h
WM_DESTROY equ 2
STYLBTN equ WS_CHILD+BS_DEFPUSHBUTTON+WS_VISIBLE+WS_TABSTOP
IDC_ARROW equ 32512
IDI_APPLICATION  equ 32512
STYLE equ CS_HREDRAW+CS_VREDRAW+CS_GLOBALCLASS
STYLEDT equ WS_CHILD+WS_VISIBLE+WS_BORDER+WS_TABSTOP
WS_BORDER equ 800000h
SW_SHOWNORMAL equ 1
WM_COMMAND equ 111h
WS_OVERLAPPEDWINDOW equ 0+WS_TABSTOP+WS_SYSMENU
WM_CREATE equ 1
WS_VISIBLE equ 10000000h
CS_VREDRAW equ 1h
CS_HREDRAW equ 2h
WS_SYSMENU equ 80000h
CS_HREDRAW equ 2h
BS_DEFPUSHBUTTON equ 1h
CS_GLOBALCLASS equ 4000h
WS_CHILD equ 40000000h
WS_TABSTOP equ 10000h
WS_EX_CLIENTEDGE                     equ 00000200h
OFN_FILEMUSTEXIST       equ 00001000h
OFN_PATHMUSTEXIST       equ 00000800h
OFN_LONGNAMES           equ 00200000h
OFN_EXPLORER            equ 00080000h
OFN_HIDEREADONLY        equ 00000004h
PAGE_READONLY             equ 2
MF_GRAYED                            equ 1h
STD_OUTPUT_HANDLE                    equ -11
WM_SETTEXT                           equ 0Ch


;
EXTERN SetFocus@4:NEAR
EXTERN SendMessageA@16:NEAR
EXTERN MessageBoxA@16:NEAR
EXTERN CreateWindowExA@48:NEAR
EXTERN DefWindowProcA@16:NEAR
EXTERN DispatchMessageA@4:NEAR
EXTERN ExitProcess@4:NEAR
EXTERN GetMessageA@16:NEAR
EXTERN GetModuleHandleA@4:NEAR
EXTERN LoadCursorA@8:NEAR
EXTERN LoadIconA@8:NEAR
EXTERN PostQuitMessage@4:NEAR
EXTERN RegisterClassA@4:NEAR
EXTERN ShowWindow@8:NEAR
EXTERN TranslateMessage@4:NEAR
EXTERN UpdateWindow@4:NEAR
EXTERN GetOpenFileNameA@4:NEAR
EXTERN DialogBoxParamA@20:NEAR
EXTERN WriteConsoleA@20:NEAR
EXTERN ReadFile@20:NEAR
EXTERN lstrlenA@4:NEAR
;

MSGSTRUCT STRUC
 MSHWND DD ?
 MSMESSAGE DD ?
 MSWPARAM DD ?
 MSLPARAM DD ?
 MSTIME DD ?
 MSPT DD ?
MSGSTRUCT ENDS

;
WNDCLASS STRUC
 CLSSTYLE DD ?
 CLWNDPROC DD ?
 CLSCBCLSEX DD ?
 CLSCBWNDEX DD ?
 CLSHINST DD ?
 CLSHICON DD ?
 CLSHCURSOR DD ?
 CLBKGROUND DD ?
 CLMENNAME DD ?
 CLNAME DD ?
WNDCLASS ENDS
;

OPENFILENAMEW STRUCT
  lStructSize        DWORD      ?
  hwndOwner          DWORD      ?
  hInstance          DWORD      ?
  lpstrFilter        DWORD      ?
  lpstrCustomFilter  DWORD      ?
  nMaxCustFilter     DWORD      ?
  nFilterIndex       DWORD      ?
  lpstrFile          DWORD      ?
  nMaxFile           DWORD      ?
  lpstrFileTitle     DWORD      ?
  nMaxFileTitle      DWORD      ?
  lpstrInitialDir    DWORD      ?
  lpstrTitle         DWORD      ?
  Flags              DWORD      ?
  nFileOffset         WORD      ?
  nFileExtension      WORD      ?
  lpstrDefExt        DWORD      ?
  lCustData          DWORD      ?
  lpfnHook           DWORD      ?
  lpTemplateName     DWORD      ?
OPENFILENAMEW ENDS
;

OPENFILENAMEA STRUCT
  lStructSize        DWORD      ?
  hwndOwner          DWORD      ?
  hInstance          DWORD      ?
  lpstrFilter        DWORD      ?
  lpstrCustomFilter  DWORD      ?
  nMaxCustFilter     DWORD      ?
  nFilterIndex       DWORD      ?
  lpstrFile          DWORD      ?
  nMaxFile           DWORD      ?
  lpstrFileTitle     DWORD      ?
  nMaxFileTitle      DWORD      ?
  lpstrInitialDir    DWORD      ?
  lpstrTitle         DWORD      ?
  Flags              DWORD      ?
  nFileOffset         WORD      ?
  nFileExtension      WORD      ?
  lpstrDefExt        DWORD      ?
  lCustData          DWORD      ?
  lpfnHook           DWORD      ?
  lpTemplateName     DWORD      ?
OPENFILENAMEA ENDS

IFDEF __UNICODE__
  OPENFILENAME equ <OPENFILENAMEW>
ELSE
  OPENFILENAME equ <OPENFILENAMEA>
ENDIF

;
_mask equ <imask>
TVITEMW STRUCT
  _mask             DWORD  ?
  hItem             DWORD  ?
  state             DWORD  ?
  stateMask         DWORD  ?
  pszText           DWORD  ?
  cchTextMax        DWORD  ?
  iImage            DWORD  ?
  iSelectedImage    DWORD  ?
  cChildren         DWORD  ?
  lParam            DWORD  ?
TVITEMW ENDS

TVITEMA STRUCT
  _mask             DWORD  ?
  hItem             DWORD  ?
  state             DWORD  ?
  stateMask         DWORD  ?
  pszText           DWORD  ?
  cchTextMax        DWORD  ?
  iImage            DWORD  ?
  iSelectedImage    DWORD  ?
  cChildren         DWORD  ?
  lParam            DWORD  ?
TVITEMA ENDS

IFDEF __UNICODE__
  TVITEM equ <TVITEMW>
ELSE
  TVITEM equ <TVITEMA>
ENDIF

TV_ITEMEX STRUCT
  imask             DWORD      ?
  hItem             DWORD      ?
  state             DWORD      ?
  stateMask         DWORD      ?
  pszText           DWORD      ?
  cchTextMax        DWORD      ?
  iImage            DWORD      ?
  iSelectedImage    DWORD      ?
  cChildren         DWORD      ?
  lParam            DWORD      ?
  iIntegral         DWORD      ?
TV_ITEMEX ENDS

TVITEMEX  equ  <TV_ITEMEX>

ITEMTYPE UNION
        itemex TVITEMEX <?>
		item TVITEM <?>
ITEMTYPE ENDS

TV_INSERTSTRUCT STRUCT
  hParent       DWORD      ?  
  hInsertAfter  DWORD ?
  item TVITEMEX <> 
TV_INSERTSTRUCT ENDS

POINT STRUCT
  x  DWORD ?
  y  DWORD ?
POINT ENDS

TV_HITTESTINFO STRUCT
  pt        POINT      <>
  flags     DWORD      ?
  hItem     DWORD      ?
TV_HITTESTINFO ENDS

TVHITTESTINFO  equ  <TV_HITTESTINFO>

NMHDR STRUCT
    hwndFrom    DWORD ?
    idFrom      DWORD ?
    code        DWORD ?
NMHDR ends

NM_TREEVIEW STRUCT
  hdr       NMHDR      <>
  action    DWORD      ?
  itemOld   TVITEM      <>
  itemNew   TVITEM      <>
  ptDrag    POINT      <>
NM_TREEVIEW ENDS

NMTREEVIEW  equ  <NM_TREEVIEW>

WM_NOTIFY                            equ 4Eh
WM_MOUSEMOVE                         equ 200h
WM_LBUTTONUP                         equ 202h
TVM_SELECTITEM  equ TV_FIRST + 11
TVM_HITTEST     equ TV_FIRST + 17
TVGN_DROPHILITE equ 0008h
TVM_GETNEXTITEM equ TV_FIRST + 10
TVGN_DROPHILITE equ 0008h
TVGN_CARET      equ 0009h


;dos header

IMAGE_DOS_HEADER STRUCT
  e_magic           WORD      ?
  e_cblp            WORD      ?
  e_cp              WORD      ?
  e_crlc            WORD      ?
  e_cparhdr         WORD      ?
  e_minalloc        WORD      ?
  e_maxalloc        WORD      ?
  e_ss              WORD      ?
  e_sp              WORD      ?
  e_csum            WORD      ?
  e_ip              WORD      ?
  e_cs              WORD      ?
  e_lfarlc          WORD      ?
  e_ovno            WORD      ?
  e_res             WORD   4 dup(?)
  e_oemid           WORD      ?
  e_oeminfo         WORD      ?
  e_res2            WORD  10 dup(?)
  e_lfanew          DWORD      ?
IMAGE_DOS_HEADER ENDS

IMAGE_FILE_HEADER STRUCT
  Machine               WORD    ?
  NumberOfSections      WORD    ?
  TimeDateStamp         DWORD   ?
  PointerToSymbolTable  DWORD   ?
  NumberOfSymbols       DWORD   ?
  SizeOfOptionalHeader  WORD    ?
  Characteristics       WORD    ?
IMAGE_FILE_HEADER ENDS

IMAGE_DATA_DIRECTORY STRUCT
  VirtualAddress    DWORD      ?
  isize             DWORD      ?
IMAGE_DATA_DIRECTORY ENDS
IMAGE_OPTIONAL_HEADER32 STRUCT
  Magic                         WORD       ?
  MajorLinkerVersion            BYTE       ?
  MinorLinkerVersion            BYTE       ?
  SizeOfCode                    DWORD      ?
  SizeOfInitializedData         DWORD      ?
  SizeOfUninitializedData       DWORD      ?
  AddressOfEntryPoint           DWORD      ?
  BaseOfCode                    DWORD      ?
  BaseOfData                    DWORD      ?
  ImageBase                     DWORD      ?
  SectionAlignment              DWORD      ?
  FileAlignment                 DWORD      ?
  MajorOperatingSystemVersion   WORD       ?
  MinorOperatingSystemVersion   WORD       ?
  MajorImageVersion             WORD       ?
  MinorImageVersion             WORD       ?
  MajorSubsystemVersion         WORD       ?
  MinorSubsystemVersion         WORD       ?
  Win32VersionValue             DWORD      ?
  SizeOfImage                   DWORD      ?
  SizeOfHeaders                 DWORD      ?
  CheckSum                      DWORD      ?
  Subsystem                     WORD       ?
  DllCharacteristics            WORD       ?
  SizeOfStackReserve            DWORD      ?
  SizeOfStackCommit             DWORD      ?
  SizeOfHeapReserve             DWORD      ?
  SizeOfHeapCommit              DWORD      ?
  LoaderFlags                   DWORD      ?
  NumberOfRvaAndSizes           DWORD      ?
  DataDirectory                 IMAGE_DATA_DIRECTORY 16 dup(<>)
IMAGE_OPTIONAL_HEADER32 ENDS

IMAGE_NT_HEADERS STRUCT
  Signature         DWORD                   ?
  FileHeader        IMAGE_FILE_HEADER       <>
  OptionalHeader    IMAGE_OPTIONAL_HEADER32 <>
IMAGE_NT_HEADERS ENDS

IMAGE_NT_HEADERS32 STRUCT
  Signature       DWORD ?
  FileHeader      IMAGE_FILE_HEADER <>
  OptionalHeader  IMAGE_OPTIONAL_HEADER32 <>
IMAGE_NT_HEADERS32 ENDS
   .code

LENSTR PROC 
 PUSH EBP
 MOV EBP, ESP
 PUSH EAX
 XOR EBX,EBX
;-------------------
 CLD
 MOV EDI, DWORD PTR [EBP+08H]
 MOV EBX, EDI
 MOV ECX, 100 ; Limit the string length
 XOR AL, AL
 REPNE SCASB ; Find the 0 character
 SUB EDI, EBX ; String length including 0
 MOV EBX, EDI
 DEC EBX
;-----------------
 POP EAX
 POP EBP
 RET 4
LENSTR ENDP
StdOut proc 
push EBP
mov EBP, ESP
sub esp, 12
 ;   LOCAL hOutPut  :DWORD
 ;   LOCAL bWritten :DWORD
 ;   LOCAL sl       :DWORD
    push STD_OUTPUT_HANDLE
    CALL GetStdHandle
 ;   invoke GetStdHandle,STD_OUTPUT_HANDLE
    mov dword ptr [ebp-4], eax

    push dword ptr [ebp+8]
    call LENSTR
    mov dword ptr [ebp-12], ebx

    push 0
    lea eax, dword ptr [ ebp - 8]
    push EAX
    push dword ptr [ebp-12]
    push dword ptr [ebp+8]
    push dword ptr [ebp-4]
    call WriteFile
;    invoke WriteFile,hOutPut,lpszText,sl,ADDR bWritten,NULL

    mov eax, dword ptr [ ebp - 8]
    mov esp, ebp
    pop ebp
    ret

StdOut endp

