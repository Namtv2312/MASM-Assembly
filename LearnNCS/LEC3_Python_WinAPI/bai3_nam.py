import win32api
from win32file import *
from pywintypes import error
 
def hook_CreateFile(params):
    '''
    Creates or opens a file or I/O device. The most commonly used I/O devices are as follows: file, file stream, directory, physical disk, volume, console buffer, tape drive, communications resource, mailslot, and pipe. The function returns a handle that can be used to access the file or device for various types of I/O depending on the file or device and the flags and attributes specified.
    '''
    lpFileName= params["lpFileName"]
    dwDesiredAccess= params["dwDesiredAccess"]
    dwShareMode= params["dwShareMode"]
    lpSecurityAttributes= params["lpSecurityAttributes"]
    dwCreationDisposition=params["dwCreationDisposition"]
    dwFlagsAndAttributes=params["dwFlagsAndAttributes"]
    hTemplateFile=params["hTemplateFile"]
    if str(lpFileName).isascii():
        try:    
            hHandle=CreateFile(lpFileName,dwDesiredAccess,dwShareMode,lpSecurityAttributes,dwCreationDisposition,dwFlagsAndAttributes,hTemplateFile)
            print("CreateFile OK")
            return hHandle
        except error as e:
            print("System Error Code:",win32api.GetLastError(),e.strerror)
            return 0  
    else:  
        try:    
            hHandle=CreateFileW(lpFileName,dwDesiredAccess,dwShareMode,lpSecurityAttributes,dwCreationDisposition,dwFlagsAndAttributes,hTemplateFile)
            print("CreateFile OK")
            return hHandle
        except error as e:
            print("System Error Code:",win32api.GetLastError(),e.strerror)
            return 0  

def hook_ReadFile(params):
    '''
    Reads data from the specified file or input/output (I/O) device. Reads occur at the position specified by the file pointer if supported by the device.
    '''
    hFile= params["hFile"]
    lpBuffer= params["lpBuffer"]
    nNumberOfBytesToRead= params["nNumberOfBytesToRead"]
    lpNumberOfBytesRead= params["lpNumberOfBytesRead"]
    lpOverlapped=params["lpOverlapped"]
    try:    
        ReadFile(hFile,lpBuffer,lpOverlapped)
        print("ReadFile OK")
        return 1
    except error as e:
        print("System Error Code:",win32api.GetLastError(),e.strerror)
        return 0

def hook_WriteFile(params):
    '''
    Writes data to the specified file or input/output (I/O) device.
    '''
    hFile= params["hFile"]
    lpBuffer= params["lpBuffer"]
    nNumberOfBytesToWrite= params["nNumberOfBytesToWrite"]
    lpNumberOfBytesWritten= params["lpNumberOfBytesWritten"]
    lpOverlapped=params["lpOverlapped"]
    try:    
        WriteFile(hFile,lpBuffer,lpOverlapped)
        print("WriteFile OK")
        return 1
    except error as e:
        print("System Error Code:",win32api.GetLastError(),e.strerror)
        return 0

def hook_CopyFile(params):
    '''
    Copies an existing file to a new file.
    '''
    lpExistingFileName= params["lpExistingFileName"]
    lpBuffer= params["lpBuffer"]
    bFailIfExists= params["bFailIfExists"]
    if str(lpExistingFileName).isascii() | str(lpBuffer).isascii():
        try:    
            CopyFile(lpExistingFileName,lpBuffer,bFailIfExists)
            print("CopyFile OK")
            return 1
        except error as e:
            print("System Error Code:",win32api.GetLastError(),e.strerror)
            return 0
    else:
        try:    
            CopyFileW(lpExistingFileName,lpBuffer,bFailIfExists)
            print("CopyFile OK")
            return 1
        except error as e:
            print("System Error Code:",win32api.GetLastError(),e.strerror)
            return 0

def hook_CloseHandle(params):
    '''
    Closes an open object handle.
    '''
    hObject=params["hObject"]
    try:    
        win32api.CloseHandle(hObject)
        print("CloseHandle OK")
        return 1
    except error as e:
        print("System Error Code:",win32api.GetLastError(),e.strerror)
        return 0

def print_help():
    import textwrap
    print(textwrap.dedent('''
    Chương trình thao tác với file
    Các Function có chức năng tương tự Windows API
    Đầu vào đầu ra tương tự, đầu vào là 1 dict chứa các đối số,...
    Có khả năng xử lý theo handle file
    1. CreateFile
    2. ReadFile
    3. WriteFile
    4. CopyFile
    5. CloseHandle
    ''')) 

def main():
    print_help()
    choices=0
    try:
        choices=int(input("Nhap vao func TESTCASE: "))
    except ValueError as e:
        print("Choices errror",e)
        print("Try again")
        import sys
        sys.exit(0)
    if choices==1:
        dict1={
                "lpFileName":"C:\\Users\\Admin\\Desktop\\trần văn nam.json",
                "dwDesiredAccess":GENERIC_READ+GENERIC_WRITE,
                "dwShareMode":0,
                "lpSecurityAttributes":None,
                "dwCreationDisposition":OPEN_EXISTING+CREATE_NEW,
                "dwFlagsAndAttributes":FILE_ATTRIBUTE_NORMAL,
                "hTemplateFile": 0    
            }
        result=hook_CreateFile(dict1) 
        print("Return Hanle Value: ",result)  
        choices=0
        try:
            choices=int(input("Nhap vao func TESTCASE: "))
        except ValueError as e:
            print("Choices errror",e)
            print("Try again")
        if choices==2:     
                num=1024
                buffer=bytearray(b" " * num)
                # buffer=AllocateReadBuffer(num)
                dict2={
                    "hFile":result,
                    "lpBuffer":buffer,
                    "nNumberOfBytesToRead":128,
                    "lpNumberOfBytesRead": num,
                    "lpOverlapped":None    
                }
                result=hook_ReadFile(dict2) 
                print(buffer.decode('utf-8'))     #print buffer after read file 

        elif choices==3:   
                buffer="Tran vAN NAM nnmmmmmmmmmmmmm".encode('utf-8')
                dict3={
                    "hFile":result,
                    "lpBuffer":buffer,
                    "nNumberOfBytesToWrite":0,
                    "lpNumberOfBytesWritten":0,
                    "lpOverlapped":None      
                }
                result=hook_WriteFile(dict3)

        elif choices==5:            
                dict5={
                    "hObject":result
                }
                result=hook_CloseHandle(dict5)
    elif choices==2:     
        print("Handle khong hop le, usage: CreateFile first")

    elif choices==3:   
        print("Handle khong hop le, usage: CreateFile first")

    elif choices==4:          
        dict1={
            "lpExistingFileName": "C:\\Users\\Admin\\Desktop\\trần vănNN.html",
            "lpBuffer": "C:\\Users\\Admin\\Desktop\\namsc2312.html",
            "bFailIfExists":1
        }
        result=hook_CopyFile(dict1)

    elif choices==5:            
        print("Handle khong hop le, usage: CreateFile first")
        
    else:
        main()

if __name__ == "__main__":
    main()

