/*+===================================================================
  File:      main.cpp

  Summary:   Simple keyboard hooking app

  Copyright: @hieudp01
===================================================================+*/

#include <Windows.h>
#include <iostream>
#include <io.h>
#include <fcntl.h>
#include <algorithm>



using namespace std;



HHOOK hKBD;
MSG message;

// Một số biến boolean để check tổ hợp phím 

bool bAFirst = false;
bool bADouble = false;
bool bASecond = false;
bool bAW = false;
bool bAW2 = false;

bool bEFirst = false;
bool bEDouble = false;
bool bESecond = false;

bool bOFirst = false;
bool bODouble = false;
bool bOSecond = false;
bool bOW = false;
bool bOW2 = false;

bool bDFirst = false;
bool bDDouble = false;

bool bUFirst = false;
bool bUW = false;
bool bUW2 = false;

bool bI = false;
bool bY = false;


bool bShift = false;

bool bSac = false;
bool bHuyen = false;
bool bHoi = false;
bool bNga = false;
bool bNang = false;




/* Hàm callback KeyboardProc */
LRESULT CALLBACK KBDhook(int nCode, WPARAM wParam, LPARAM lParam)
{
    KBDLLHOOKSTRUCT* pHookStruct = (KBDLLHOOKSTRUCT*)(lParam);
    if (nCode == HC_ACTION) {
       
        // Các trường hợp nếu các phím được bấm, ở đây sẽ check các phím có tổ hợp và có thể có dấu
        // Nếu phím được bấm, các biến boolean sẽ set thành true

        if ( (GetKeyState(VK_RSHIFT) & 0x8000 ) || (GetKeyState(VK_LSHIFT) & 0x8000)) {
            bShift = true;
        }

        if (GetKeyState('A') & 0x8000) {
            bAFirst = true;
        }

        if (GetKeyState('D') & 0x8000) {
            bDFirst = true;
        }

        if (GetKeyState('E') & 0x8000) {
            bEFirst = true;
        }

        if (GetKeyState('O') & 0x8000) {
            bOFirst = true;
        }

        if (GetKeyState('U') & 0x8000) {
            bUFirst = true;
        }

        if (GetKeyState('I') & 0x8000) {
            bI = true;
        }

        if (GetKeyState('Y') & 0x8000) {
            bY = true;
        }

        switch (wParam) {
        case WM_KEYDOWN:
            // Nếu người dùng chỉ nhập vào các chữ cái bình thường mà không dùng shift
            // nó sẽ hiển thị ra các chữ cái thường
            
            if (pHookStruct->vkCode >= 'A' && pHookStruct->vkCode <= 'Z' && bShift == false) {
                wcout << (char)(pHookStruct->vkCode + 0x20);
            }

            if (bShift == true) {
                if (pHookStruct->vkCode >= 'A' && pHookStruct->vkCode <= 'Z') {
                    wcout << (char)(pHookStruct->vkCode);
                    bShift = false;
                    
                }
            }
            
            
            switch (pHookStruct->vkCode) {

            // Nếu bấm phim backspace thì ký tự nó sẽ back về 1 index
            case VK_BACK:
                wcout << '\b' << " " << '\b';
                break;

            // Phím cách
            case VK_SPACE:
                wcout << ' ';
                break;

            case VK_RETURN:
                wcout << '\n';
                break;

            
            // Ký tự â
            // Ở đây, biến bAFirst được set thành false để không bị nhầm lẫn, biến bADouble để check chữ â không dấu
            // Biến bASecond được dùng để check chữ â có dấu
            case 'A':
                if (bAFirst == true && bShift == false) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"â");
                    bADouble = true;
                    bAFirst = false;
                    bASecond = true;
                }
              
                break;

                   
            
            // Ký tự ê
            case 'E':
                if (bEFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ê");
                    bEFirst = false;
                    bEDouble = true;
                    bESecond = true;
                }
                break;

            // Ký tự ô 
            case 'O':
                if (bOFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ô");
                    bOFirst = false;
                    bODouble = true;
                    bOSecond = true;
                }
                break;

            // Ký tự đ
            case 'D':
                if (bDFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"đ");
                    bDFirst = false;
                    bDDouble = true;
                }
                break;

            case 'W':
                // Ký tự ă
                if (bAFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ă");
                    bAW = true;
                    bAFirst = false;
                    bAW2 = true;
                }

                // Ký tự ơ
                if (bOFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ơ");
                    bOW = true;
                    bOFirst = false;
                    bOW2 = true;
                }

                // Ký tự ư
                if (bUFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ư");
                    bUFirst = false;
                    bUW = true;
                    bUW2 = true;
                }
                break;


            // Dấu huyền
            case 'F':
                // Ký tự 'y'
                if (bY && !bUFirst && !bAFirst) {
                    // Kiểm tra 'iê'
                    if (!bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ỳ");
                        bHuyen = true;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ề");
                        bHuyen = true;
                        bESecond = false;
                        bI = false;
                    }
                }

                // Ký tự 'i'
                if (bI) {
                    // Kiểm tra 'iê'
                    if (bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ề");
                        bHuyen = true;
                        bESecond = false;
                        bI = false;
                        
                    }

                    // Kiểm tra 'ia'
                    else if (bAFirst) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ìa");
                        bHuyen = true;
                        bAFirst = false;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ì");
                        bHuyen = true;
                        bI = false;
                    }
                }

                // Ký tự 'a'
                if (bAFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"à");
                    bHuyen = true;
                    bAFirst = false;
                }

                // Ký tự 'ă'
                else if (bAW2) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ằ");
                    bHuyen = true;
                    bAFirst = false;
                    bAW2 = false;
                }

                // Ký tự 'â'
                else if (bASecond) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ầ");
                    bHuyen = true;
                    bAFirst = false;
                    bASecond = false;
                }

                // Ký tự 'u'
                if (bUFirst) {

                    
                    
                    // Kiểm tra "uy"
                    if (bY) {
                        if (bESecond) {
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ề");
                            bHuyen = true;
                            bUFirst = false;
                        }
                        else {
                            wcout << '\b' << " " << '\b';
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ỳ");
                            bHuyen = true;
                            bUFirst = false;
                        }
                    }

                    // Kiểm tra "uô"
                    else if (bOSecond) {
                        wcout << '\b' << " " << '\b';
                        
                        wprintf(L"ồ");
                        bHuyen = true;
                        bUFirst = false;
                    }
                    

                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ù");
                        bHuyen = true;
                        bUFirst = false;
                    }
                }

                // Ký tự 'ư'
                else if (bUW2) {

                    // Kiểm tra "ươ"
                    if (!bOW2) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ừ");
                        bHoi = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ờ");
                        bHoi = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                }

                // Ký tự 'e'
                if (bEFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"è");
                    bHuyen = true;
                    bAFirst = false;
                }

                // Ký tự 'ê'
                else if (bESecond) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ề");
                    bHuyen = true;
                    bEFirst = false;
                    bESecond = false;
                }

                
                // Ký tự 'o'
                if (bOFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ò");
                    bHuyen = true;
                    bOFirst = false;
                }

                // Ký tự 'ơ'
                else if (bOW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ờ");
                    bHuyen = true;
                    bOFirst = false;
                    bOW2 = false;
                }

                // Ký tự 'ô'
                else if (bOSecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ồ");
                    bHuyen = true;
                    bOFirst = false;
                    bOSecond = false;
                }

                break;

            // Dấu hỏi 
            case 'R':
                
                // Ký tự 'y'
                if (bY && !bUFirst && !bAFirst) {
                    // Kiểm tra 'iê'
                    if (!bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ỷ");
                        bHoi = true;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ể");
                        bHoi = true;
                        bESecond = false;
                        bI = false;
                    }
                }

                // Ký tự 'i'
                if (bI) {
                    // Kiểm tra 'iê'
                    if (bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ể");
                        bHoi = true;
                        bESecond = false;
                        bI = false;

                    }

                    // Kiểm tra 'ia'
                    else if (bAFirst) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ỉa");
                        bHoi = true;
                        bAFirst = false;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ỉ");
                        bHoi = true;
                        bI = false;
                    }
                }

                // Ký tự 'a'
                if (bAFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ả");
                    bHoi = true;
                    bAFirst = false;
                }

                // Ký tự 'ă'
                if (bAW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ẳ");
                    bHoi = true;
                    bAFirst = false;
                    bAW2 = false;
                }

                // Ký tự 'â'
                if (bASecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ẩ");
                    bHoi = true;
                    bAFirst = false;
                    bASecond = false;
                }

                // Ký tự 'u'
                if (bUFirst) {

                    // Kiểm tra "uy"
                    if (bY) {
                        if (bESecond) {
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ể");
                            bHoi = true;
                            bUFirst = false;
                        }
                        else {
                            wcout << '\b' << " " << '\b';
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ỷ");
                            bHoi = true;
                            bUFirst = false;
                        }
                    }

                    // Kiểm tra "uô"
                    else if (bOSecond) {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ổ");
                        bHoi = true;
                        bUFirst = false;
                    }

                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ủ");
                        bHoi = true;
                        bUFirst = false;
                    }
                }

                // Ký tự 'ư'
                else if (bUW2) {

                    // Kiểm tra "ươ"
                    if (!bOW2) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ử");
                        bHoi = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ở");
                        bHoi = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                }


                // Ký tự 'e'
                if (bEFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ẻ");
                    bHoi = true;
                    bEFirst = false;
                }

                // Ký tự 'ê'
                else if (bESecond) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ể");
                    bHoi = true;
                    bEFirst = false;
                    bESecond = false;
                }

                
                // Ký tự 'o'
                if (bOFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ỏ");
                    bHoi = true;
                    bOFirst = false;
                }

                // Ký tự 'ơ'
                else if (bOW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ở");
                    bHoi = true;
                    bOFirst = false;
                    bOW2 = false;
                }

                // Ký tự 'ô'
                else if (bOSecond) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ổ");
                    bHoi = true;
                    bOFirst = false;
                    bOSecond = false;
                }

               
                
                break;
             // Dấu sắc 
            case 'S':

                // Ký tự 'y'
                if (bY && !bUFirst && !bAFirst) {
                    // Kiểm tra 'iê'
                    if (!bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ý");
                        bSac = true;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ế");
                        bSac = true;
                        bESecond = false;
                        bI = false;
                    }
                }

                // Ký tự 'i'
                if (bI) {

                    // Kiểm tra 'iê'
                    if (bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ế");
                        bSac = true;
                        bESecond = false;
                        bI = false;

                    }

                    // Kiểm tra 'ia'
                    else if (bAFirst) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';

                        wprintf(L"ía");
                        bSac = true;
                        bAFirst = false;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"í");
                        bSac = true;
                        bI = false;
                    }
                }

                // Ký tự 'a'
                if (bAFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"á");
                    bSac = true;
                    bAFirst = false;
                }

                // Ký tự 'ă'
                if (bAW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ắ");
                    bSac = true;
                    bAFirst = false;
                    bAW2 = false;
                }

                // Ký tự 'â'
                if (bASecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ấ");
                    bHuyen = true;
                    bAFirst = false;
                    bASecond = false;
                }

                // Ký tự 'u'
                if (bUFirst) {

                    // Kiểm tra "uy"
                    if (bY) {
                        if (bESecond) {
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ế");
                            bSac = true;
                            bUFirst = false;
                        }
                        else {
                            wcout << '\b' << " " << '\b';
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ý");
                            bSac = true;
                            bUFirst = false;
                        }
                    }

                    // Kiểm tra "uô"
                    else if (bOSecond) {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ố");
                        bSac = true;
                        bUFirst = false;
                    }

                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ú");
                        bSac = true;
                        bUFirst = false;
                    }
                }

                // Ký tự 'ư'
                else if (bUW2) {

                    // Kiểm tra "ươ
                    if (!bOW2) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ứ");
                        bSac = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ớ");
                        bSac = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                }

                // Ký tự 'e'
                if (bEFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"é");
                    bSac = true;
                    bEFirst = false;
                }

                // Ký tự 'ê'
                else if (bESecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ế");
                    bSac = true;
                    bEFirst = false;
                    bESecond = false;
                }

                // Ký tự 'o'
                if (bOFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ó");
                    bHuyen = true;
                    bOFirst = false;
                }

                // Ký tự 'ơ'
                else if (bOW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ớ");
                    bSac = true;
                    bOFirst = false;
                    bOW2 = false;
                }

                // Ký tự 'ô'
                else if (bOSecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ố");
                    bSac = true;
                    bOFirst = false;
                    bOSecond = false;
                }
                

                break;

            // Dấu nặng 
            case 'J':

                // Ký tự 'y'
                if (bY && !bUFirst && !bAFirst) {
                    // Kiểm tra 'iê'
                    if (!bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ỵ");
                        bNang = true;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ệ");
                        bNang = true;
                        bESecond = false;
                        bI = false;
                    }
                }

                // Ký tự 'i'
                if (bI) {
                    // Kiểm tra 'iê'
                    if (bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ệ");
                        bNang = true;
                        bESecond = false;
                        bI = false;

                    }

                    // Kiểm tra 'ia'
                    else if (bAFirst) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';

                        wprintf(L"ịa");
                        bNang = true;
                        bAFirst = false;
                        bI = false;
                    }

                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ị");
                        bNang = true;
                        bI = false;
                    }
                }

                // Ký tự 'a'
                if (bAFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ạ");
                    bNang = true;
                    bAFirst = false;
                }

                // Ký tự 'ă'
                if (bAW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ặ");
                    bNang = true;
                    bAFirst = false;
                    bAW2 = false;
                }

                // Ký tự 'â'
                if (bASecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ậ");
                    bNang = true;
                    bAFirst = false;
                    bASecond = false;
                }

                // Ký tự 'u'
                if (bUFirst) {

                    // Kiểm tra "uy"
                    if (bY) {
                        if (bESecond) {
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ệ");
                            bNang = true;
                            bUFirst = false;
                        }
                        else {
                            wcout << '\b' << " " << '\b';
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ỵ");
                            bNang = true;
                            bUFirst = false;
                        }
                    }

                    // Kiểm tra "uô"
                    else if (bOSecond) {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ộ");
                        bNang = true;
                        bUFirst = false;
                    }

                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ụ");
                        bNang = true;
                        bUFirst = false;
                    }
                }

                // Ký tự 'ư'
                else if (bUW2) {

                    // Kiểm tra "ươ
                    if (!bOW2) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ự");
                        bNang = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ợ");
                        bNang = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                }

                // Ký tự 'e'
                if (bEFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ẹ");
                    bNang = true;
                    bEFirst = false;
                }

                // Ký tự 'ê'
                else if (bESecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ệ");
                    bNang = true;
                    bEFirst = false;
                    bESecond = false;
                }

                // Ký tự 'o'
                if (bOFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ọ");
                    bNang = true;
                    bOFirst = false;
                }

                // Ký tự 'ơ'
                else if (bOW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ợ");
                    bNang = true;
                    bOFirst = false;
                    bOW2 = false;
                }

                // Ký tự 'ô'
                else if (bOSecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ộ");
                    bNang = true;
                    bOFirst = false;
                    bOSecond = false;
                }

                

               

                break;
            
            // Dấu ngã
            case 'X':
                
                // Ký tự 'y'
                if (bY && !bUFirst && !bAFirst) {
                    // Kiểm tra 'iê'
                    if (!bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ỹ");
                        bNga = true;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ễ");
                        bNga = true;
                        bESecond = false;
                        bI = false;
                    }
                }

                // Ký tự 'i'
                if (bI) {
                    // Kiểm tra 'iê'
                    if (bESecond) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ễ");
                        bNga = true;
                        bESecond = false;
                        bI = false;

                    }

                    // Kiểm tra 'ia'
                    else if (bAFirst) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ĩa");
                        bNga = true;
                        bAFirst = false;
                        bI = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ĩ");
                        bNga = true;
                        bI = false;
                    }
                }

                // Ký tự 'a'
                if (bAFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ã");
                    bNga = true;
                    bAFirst = false;
                }

                // Ký tự 'ă'
                if (bAW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ẵ");
                    bNga = true;
                    bAFirst = false;
                    bAW2 = false;
                }

                // Ký tự 'â'
                if (bASecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ẫ");
                    bNga = true;
                    bAFirst = false;
                    bASecond = false;
                }

                // Ký tự 'u'
                if (bUFirst) {

                    // Kiểm tra "uy"
                    if (bY) {
                        if (bESecond) {
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ễ");
                            bNga = true;
                            bUFirst = false;
                        }
                        else {
                            wcout << '\b' << " " << '\b';
                            wcout << '\b' << " " << '\b';
                            wprintf(L"ỹ");
                            bNga = true;
                            bUFirst = false;
                        }
                    }

                    // Kiểm tra "uô"
                    else if (bOSecond) {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ỗ");
                        bNga = true;
                        bUFirst = false;
                    }

                    else {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ũ");
                        bNga = true;
                        bUFirst = false;
                    }
                }


                // Ký tự 'ư'
                else if (bUW2) {

                    // Kiểm tra "ươ
                    if (!bOW2) {
                        wcout << '\b' << " " << '\b';
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ữ");
                        bNga = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                    else {
                        wcout << '\b' << " " << '\b';
                        wprintf(L"ỡ");
                        bNga = true;
                        bUFirst = false;
                        bUW2 = false;
                    }
                }



                // Ký tự 'e'
                if (bEFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ẽ");
                    bNga = true;
                    bEFirst = false;
                }

                // Ký tự 'ê'
                else if (bESecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ễ");
                    bNga = true;
                    bEFirst = false;
                    bESecond = false;
                }

               

                // Ký tự 'o'
                if (bOFirst) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"õ");
                    bNga = true;
                    bOFirst = false;
                }

                // Ký tự 'ơ'
                else if (bOW2 == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ỡ");
                    bNga = true;
                    bOFirst = false;
                    bOW2 = false;
                }

                // Ký tự 'ô'
                else if (bOSecond == true) {
                    wcout << '\b' << " " << '\b';
                    wcout << '\b' << " " << '\b';
                    wprintf(L"ỗ");
                    bNga = true;
                    bOFirst = false;
                    bOSecond = false;
                }

               

            

                break;
            }
    
           
           
             
            break;
        
        case WM_KEYUP:
            switch (pHookStruct->vkCode) {
            // Khi phím 'A' được release, nếu hoàn thành combo a + a = â, 2 biến boolean sẽ set về false
            case 'A':
                if (bADouble == true) {
                    bAFirst = false;
                    bADouble = false;
                }
                break;

            case 'W':
                // Khi phím 'W' được release, nếu hoàn thành combo a + w = ă, 2 biến boolean sẽ set về false
                if (bAW == true) {
                    bAFirst = false;
                    bAW = false;
                }

                // Nếu hoàn thành combo o + w = ơ, 2 biến boolean sẽ set về false
                else if (bOW == true) {
                    bOFirst = false;
                    bOW = false;
                }

                // Nếu hoàn thành combo u + w = ư, 2 biến boolean sẽ set về false
                else if (bUW == true) {
                    bUFirst = false;
                    bUW = false;
                }
                break;

            // Khi phím 'E' được release, nếu hoàn thành combo e + e = ê, 2 biến boolean sẽ set về false
            case 'E':
                if (bEDouble == true) {
                    bEFirst = false;
                    bEDouble = false;
                }
                break;

            // Khi phím 'O' được release, nếu hoàn thành combo o + o = ô, 2 biến boolean sẽ set về false
            case 'O':
                if (bODouble == true) {
                    bOFirst = false;
                    bODouble = false;
                }
                break;

            // Khi phím 'D' được release, nếu hoàn thành combo d + d = đ, 2 biến boolean sẽ set về false
            case 'D':
                if (bDDouble == true) {
                    bDFirst = false;
                    bDDouble = false;
                }
                break;

            // Khi các phím dấu câu được release, các biến boolean của dấu câu sẽ được set về false
            case 'F':
                if (bHuyen == true) {
                   
                    bHuyen = false;
                }
                break;

            case 'S':
                if (bSac == true) {

                    bSac = false;
                }
                break;

            case 'R':
                if (bHoi == true) {

                    bHoi = false;
                }
                break;

            case 'J':
                if (bNang == true) {

                    bNang = false;
                }
                break;

            case 'X':
                if (bNga == true) {

                    bNga = false;
                }
                break;

            // Khi nhấn phím Space, các biến lưu trạng thái của phím bắt đầu combo sẽ được 
            // reset về false
            case VK_SPACE:
                if (bAFirst == true) {
                    bAFirst = false;
                }

                if (bOFirst == true) {
                    bOFirst = false;
                }

                if (bEFirst == true) {
                    bEFirst = false;
                }

                if (bDFirst == true) {
                    bDFirst = false;
                }

                if (bUFirst == true) {
                    bUFirst = false;
                }

                if (bASecond == true) {
                    bASecond = false;
                }

                if (bAW2  == true) {
                    bAW2 = false;
                }
                
                if (bESecond == true) {
                    bESecond = false;
                }

                if (bOSecond == true) {
                    bOSecond = false;
                }

                if (bOW2 == true) {
                    bOW2 = false;
                }

                if (bUW2 == true) {
                    bUW2 = false;
                }

                if (bI == true) {
                    bI = false;
                }

                if (bY == true) {
                    bY = false;
                }

                
                break;

            // Khi nhấn phím Enter (xuống dòng), các biến lưu trạng thái của phím bắt đầu combo sẽ được 
            // reset về false 
            case VK_RETURN:
                if (bAFirst == true) {
                    bAFirst = false;
                }

                if (bOFirst == true) {
                    bOFirst = false;
                }

                if (bEFirst == true) {
                    bEFirst = false;
                }

                if (bDFirst == true) {
                    bDFirst = false;
                }

                if (bUFirst == true) {
                    bUFirst = false;
                }

                if (bASecond == true) {
                    bASecond = false;
                }

                if (bAW2 == true) {
                    bAW2 = false;
                }

                if (bESecond == true) {
                    bESecond = false;
                }

                if (bOSecond == true) {
                    bOSecond = false;
                }

                if (bOW2 == true) {
                    bOW2 = false;
                }

                if (bUW2 == true) {
                    bUW2 = false;
                }

                if (bI == true) {
                    bI = false;
                }

                if (bY == true) {
                    bY = false;
                }

                break;

            }



        }




    }
    Sleep(2);
    return CallNextHookEx(NULL, nCode, wParam, lParam);
}

int main() {
    _setmode(_fileno(stdout), _O_U16TEXT);
    HINSTANCE hInstance = GetModuleHandle(NULL);
    hKBD = SetWindowsHookEx(WH_KEYBOARD_LL, &KBDhook, hInstance, 0);


    while (GetMessage(&message, NULL, NULL, NULL) > 0) {
        TranslateMessage(&message);
        DispatchMessage(&message);
    }

    UnhookWindowsHookEx(hKBD);
    CloseHandle(hInstance);

    return 0;
}