import ctypes
import win32api
from win32 import *
from pywintypes import error


 
def hook_memset(params):
    '''
    Sets a buffer to a specified character.
    '''
    dest=params["dest"]
    c=params["c"]
    count=params["count"]

    for i in range(count): 
        dest[i] = c 
def hook_memcpy(params):
    '''
    Copies bytes between buffers. More secure versions of these functions are available
    '''
    dest=params["dest"]
    src=params["src"]
    count=params["count"]

    for i in range(count): 
        dest[i] = src[i]
def hook_memcmp(params):
    '''
    Compares characters in two buffers.
    '''
    buffer1=params["buffer1"]
    buffer2=params["buffer2"]
    count=params["count"]

    import ctypes
    return ctypes.c_int.from_buffer(buffer1).value - ctypes.c_int.from_buffer(buffer2).value
def print_help():
    import textwrap
    print(textwrap.dedent('''
    Chương trình thao tác với process
    Các Function có chức năng tương tự Windows API
    Đầu vào đầu ra tương tự, đầu vào là 1 dict chứa các đối số,...
    Có khả năng xử lý theo handle file
    GetCurrentProcess
    GetCurrentProcessId
    TerminateProcess
    CreateProcess
    OpenProcess
    GetProcessHeap
    Process32Next
    Process32First
    GetExitCodeProcess
    WriteProcessMemory
    ReadProcessMemory
    GetProcessId
    ''')) 

def main():
    print_help()
    print("TESTCASE EXAMPLE")
    # Driver code 
    arr = [1, 2, 3, 4, 5] 
    arr2=[0,0,0,0,0,0,0]
    dict={
        "dest":arr2,
        "src":arr,
        'count':5
    }

    # hook_memset(dict) 
    # print("Modified array is", arr)
   
    hook_memcpy(dict)
    print(arr2)
    # print("Terminates the current process ",hook_TerminateProcess(dict_1)) #dùng ở cuối, dùng bây giờ, tiến trình bị kết thúc, không còn làm được gì nữa
    dict_CrteateProcess={
        "lpApplicationName":"C:\\Windows\\system32\\notepad.exe",
        "lpCommandLine":0,
        "lpProcessAttributes":0,
        "lpThreadAttributes":0,
        "bInheritHandles":False,
        "dwCreationFlags":0,
        "lpEnvironment":0,
        "lpCurrentDirectory":0 ,
        "lpStartupInfo":"",
        "lpProcessInformation":""
    }
if __name__ == "__main__":
    main()
    


