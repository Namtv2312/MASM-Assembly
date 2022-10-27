; The edit.inc file
; Constants
WM_SETFOCUS equ 7h
; The message that arrives when the window is closed
WM_DESTROY equ 2
; The message that arrives when the window is created
WM_CREATE equ 1
; The message that arrives when something happens
; to the window controls
WM_COMMAND equ 111h
; The message that allows you to send the string to the window
WM_SETTEXT equ 0Ch
; The message that allows you to receive the string
WM_GETTEXT equ 0Dh
; Window properties
CS_VREDRAW equ 1h
CS_HREDRAW equ 2h
CS_GLOBALCLASS equ 4000h
WS_TABSTOP equ 10000h
WS_SYSMENU equ 80000h
ES_READONLY equ 800h
ES_AUTOHSCROLL equ 80h
WS_OVERLAPPEDWINDOW equ 0+WS_TABSTOP+WS_SYSMENU
STYLE equ CS_HREDRAW+CS_VREDRAW+CS_GLOBALCLASS
CS_HREDRAW equ 2h
BS_DEFPUSHBUTTON equ 1h
WS_VISIBLE equ 10000000h
WS_CHILD equ 40000000h
WS_BORDER equ 800000h
STYLBTN equ WS_CHILD+BS_DEFPUSHBUTTON+WS_VISIBLE+WS_TABSTOP
STYLEDT equ WS_CHILD+WS_VISIBLE+WS_BORDER+WS_TABSTOP+ES_AUTOHSCROLL							
STYLRET equ ES_READONLY+WS_VISIBLE+WS_BORDER+WS_TABSTOP+WS_CHILD+ES_AUTOHSCROLL
; Standard icon identifier
IDI_APPLICATION equ 32512
; Cursor identifier
IDC_ARROW equ 32512
; Window display mode -- normal
SW_SHOWNORMAL equ 1
; Prototypes of external procedures
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
; Structures
; Message structure
MSGSTRUCT STRUC
 MSHWND DD ?
 MSMESSAGE DD ?
 MSWPARAM DD ?
 MSLPARAM DD ?
 MSTIME DD ?
 MSPT DD ?
MSGSTRUCT ENDS
;---- Window class structure
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