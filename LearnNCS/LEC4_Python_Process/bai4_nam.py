import ctypes
from ctypes import byref, Structure, sizeof
from ctypes.wintypes import BYTE, WORD, DWORD, LPWSTR, HANDLE
import win32api
from win32process import *
from pywintypes import error

def format_system_message(errno):
	"""
	Call FormatMessage with a system error number to retrieve
	the descriptive error message.
	"""
	# first some flags used by FormatMessageW
	ALLOCATE_BUFFER = 0x100
	ARGUMENT_ARRAY = 0x2000
	FROM_HMODULE = 0x800
	FROM_STRING = 0x400
	FROM_SYSTEM = 0x1000
	IGNORE_INSERTS = 0x200
	# Let FormatMessageW allocate the buffer (we'll free it below)
	# Also, let it know we want a system error message.
	flags = ALLOCATE_BUFFER | FROM_SYSTEM
	source = None
	message_id = errno
	language_id = 0
	result_buffer = ctypes.wintypes.LPWSTR()
	buffer_size = 0
	arguments = None
	bytes = ctypes.windll.kernel32.FormatMessageW(
		flags,
		source,
		message_id,
		language_id,
		ctypes.byref(result_buffer),
		buffer_size,
		arguments,
		)
	# note the following will cause an infinite loop if GetLastError
	#  repeatedly returns an error that cannot be formatted, although
	#  this should not happen.
	message = result_buffer.value
	ctypes.windll.kernel32.LocalFree(result_buffer)
	return message

LPBYTE  = ctypes.POINTER(BYTE)
class PROCESS_INFORMATION(Structure):
    _fields_ = [
        ("hProcess",         HANDLE), ("hThread",          HANDLE),
        ("dwProcessId",      DWORD),  ("dwThreadId",       DWORD),
    ]
LPPROCESS_INFORMATION = ctypes.POINTER(PROCESS_INFORMATION)

class STARTUPINFOW(Structure):
    _fields_ = [
        ("cb",              DWORD),  ("lpReserved",    LPWSTR),
        ("lpDesktop",       LPWSTR), ("lpTitle",       LPWSTR),
        ("dwX",             DWORD),  ("dwY",           DWORD),
        ("dwXSize",         DWORD),  ("dwYSize",       DWORD),
        ("dwXCountChars",   DWORD),  ("dwYCountChars", DWORD),
        ("dwFillAtrribute", DWORD),  ("dwFlags",       DWORD),
        ("wShowWindow",     WORD),   ("cbReserved2",   WORD),
        ("lpReserved2",     LPBYTE), ("hStdInput",     HANDLE),
        ("hStdOutput",      HANDLE), ("hStdError",     HANDLE),
    ]

class PROCESSENTRY32(ctypes.Structure):
    _fields_ = [("dwSize", ctypes.c_ulong),
                ("cntUsage", ctypes.c_ulong),
                ("th32ProcessID", ctypes.c_ulong),
                ("th32DefaultHeapID", ctypes.c_ulong),
                ("th32ModuleID", ctypes.c_ulong),
                ("cntThreads", ctypes.c_ulong),
                ("th32ParentProcessID", ctypes.c_ulong),
                ("pcPriClassBase", ctypes.c_ulong),
                ("dwFlags", ctypes.c_ulong),
                ("szExeFile", ctypes.c_char * 260)]
    
def hook_GetCurrentProcess():
    '''
    Retrieves a pseudo handle for the current process.
    '''
    return GetCurrentProcess() 

def hook_GetCurrentProcessId():
    '''
    Retrieves the process identifier of the calling process.
    '''
    return GetCurrentProcessId()

def hook_TerminateProcess(params):
    '''
    Terminates the specified process and all of its threads.
    '''
    hProcess= params["hProcess"]
    uExitCode= params["uExitCode"]
    
    try:    
        TerminateProcess(hProcess,uExitCode)
        print("TerminateProcess  OK")
        return 1
    except error as e:
        print("System Error Code:",win32api.GetLastError(),e.strerror)
        return 0

def hook_CreateProcess(params):
    '''
    Creates a new process and its primary thread. The new process runs in the security context of the calling process.
    '''
    lpApplicationName= params["lpApplicationName"]
    lpCommandLine= params["lpCommandLine"]
    lpProcessAttributes= params["lpProcessAttributes"]
    lpThreadAttributes= params["lpThreadAttributes"]
    bInheritHandles= params["bInheritHandles"]
    dwCreationFlags= params["dwCreationFlags"]
    lpEnvironment= params["lpEnvironment"]
    lpCurrentDirectory= params["lpCurrentDirectory"]
    lpStartupInfo= params["lpStartupInfo"]
    lpProcessInformation= params["lpProcessInformation"]
    if str(lpApplicationName).isascii():
        try:    
            return_val=ctypes.windll.kernel32.CreateProcessA(lpApplicationName,lpCommandLine,lpProcessAttributes,lpThreadAttributes,bInheritHandles,dwCreationFlags,lpEnvironment,lpCurrentDirectory,lpStartupInfo,lpProcessInformation)
            if(return_val==0):
                print(format_system_message(ctypes.windll.kernel32.GetLastError()))
                return 0
            else:
                print("CreateProcess OK")
                return 1
        except:
            print("CreateProcess Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))
            return 0
    else:
        try:    
            return_val=ctypes.windll.kernel32.CreateProcessW(lpApplicationName,lpCommandLine,lpProcessAttributes,lpThreadAttributes,bInheritHandles,dwCreationFlags,lpEnvironment,lpCurrentDirectory,lpStartupInfo,lpProcessInformation)
            if(return_val==0):
                print(format_system_message(ctypes.windll.kernel32.GetLastError()))
                return 0
            else:
                print("CreateProcess OK")
                return 1
        except:
            print("CreateProcess Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))
            return 0

def hook_OpenProcess(params):
    '''
    Opens an existing local process object.
    '''
    dwDesiredAccess=params["dwDesiredAccess"]
    bInheritHandle=params["bInheritHandle"]
    dwProcessId=params["dwProcessId"]
    try:    
        hHandle=win32api.OpenProcess(dwDesiredAccess,bInheritHandle,dwProcessId)
        print("OpenProcess OK")
        return hHandle
    except error as e:
        print("System Error Code:",win32api.GetLastError(),e.strerror)
        return 0
    
def hook_GetProcessHeap():
    '''
    Retrieves a handle to the default heap of the calling process. This handle can then be used in subsequent calls to the heap functions.
    '''
    try:
        return ctypes.windll.kernel32.GetProcessHeap()
    except:
        print(ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))

def hook_Process32First(params):
    '''
    Retrieves information about the first process encountered in a system snapshot.
    '''
    hSnapshot=params["hSnapshot"]
    lppe=params["lppe"]
    try:    
        return_val=ctypes.windll.kernel32.Process32First(hSnapshot,lppe)
        if return_val==0:
          print("the first entry of the process list NOT copied to the buffer")
          return 0
        else:
            print("Process32First OK")
            return 1
    except :
       print("Process32First Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))
       return 0

def hook_Process32Next(params):
    '''
    Retrieves information about the next process recorded in a system snapshot.
    '''
    hSnapshot=params["hSnapshot"]
    lppe=params["lppe"]
    try:    
        return_val=ctypes.windll.kernel32.Process32Next(hSnapshot,lppe)
        if return_val==0:
          print("the next entry of the process list NOT copied to the buffer ")
          return 0
        else:
            print("Process32Next OK")
            return 1
    except:
       print("Process32Next Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))
       return 0
    
def hook_GetExitCodeProcess(params):
    '''
    Retrieves the termination status of the specified process.
    '''
    hProcess=params["hProcess"]
    lpExitCode=params["lpExitCode"]
    res_val=0
    try:  
        lpExitCode=GetExitCodeProcess(hProcess)
        print("GetExitCodeProcess OK ")
        return lpExitCode
    except error as e:
        print("System Error Code:",win32api.GetLastError(),e.strerror)
        return 0
    
def hook_WriteProcessMemory(params):
    '''
    Writes data to an area of memory in a specified process. The entire area to be written to must be accessible or the operation fails.
    '''
    hProcess=params["hProcess"]
    lpBaseAddress=params["lpBaseAddress"]
    lpBuffer=params["lpBuffer"]
    nSize=params["nSize"]
    lpNumberOfBytesWritten=params["lpNumberOfBytesWritten"]
    try:    
        return_val=ctypes.windll.kernel32.WriteProcessMemory(hProcess,lpBaseAddress,lpBuffer,nSize,lpNumberOfBytesWritten)
        if(return_val==0):
            print(format_system_message(ctypes.windll.kernel32.GetLastError()))
        else:
            print("WriteProcessMemory  OK")
            return return_val
    except:
        print(" Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))
        return 0
    
def hook_ReadProcessMemory(params):
    hProcess=params["hProcess"]
    lpBaseAddress=params["lpBaseAddress"]
    lpBuffer=params["lpBuffer"]
    nSize=params["nSize"]
    lpNumberOfBytesRead=params["lpNumberOfBytesRead"]
    try:    
        return_val=ctypes.windll.kernel32.ReadProcessMemory(hProcess,lpBaseAddress,lpBuffer,nSize,lpNumberOfBytesRead)
        if(return_val==0):
            print(" Read Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))
        else:
            print("ReadProcessMemory  OK")
            return 1
    except:
        print(" Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))
        return 0
    
def hook_GetProcessId(params):
    '''
    Retrieves the process identifier of the specified process.
    '''
    Process=params["Process"]
    try:
        return_val= GetProcessId(Process  ) 
        if(return_val==0):
            print(" Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))
        else:return return_val
    except:
        print(" Not Complete.  System Error Code:",ctypes.windll.kernel32.GetLastError(),format_system_message(ctypes.windll.kernel32.GetLastError()))

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
    
    #---------------------->GetCurrentProcess
    print("Handle for current process:",hook_GetCurrentProcess())
   
    #--------------------------->GetCurrentProcessId
    print("Process identifier for calling process:",hook_GetCurrentProcessId())
    
    #--------------------------->CreateProcess
    pi = PROCESS_INFORMATION()
    si=STARTUPINFOW()
    dict_CrteateProcess={
        "lpApplicationName":"C:\\Windows\\System32\\notepad.exe".encode('utf-8'),
        "lpCommandLine":"",
        "lpProcessAttributes":None,
        "lpThreadAttributes":None,
        "bInheritHandles":False,
        "dwCreationFlags":None,
        "lpEnvironment":None,
        "lpCurrentDirectory":None ,
        "lpStartupInfo":byref(si),
        "lpProcessInformation":byref(pi)
    }
    hook_CreateProcess(dict_CrteateProcess) 

    #--------------------------------->OpenProcess
    from win32gui import FindWindow
    hd=FindWindow(None,None)                     #handle windows manager
    print(hd)
    pid=GetWindowThreadProcessId(hd)[1]
    print(pid)

    dict_OpenProcess={
        "dwDesiredAccess":40 ,            #desireAccess: PROCESS_VM_OPERATION | PROCESS_VM_WRITE 
        "bInheritHandle":False,
        "dwProcessId":pid
    }
    hProcess=hook_OpenProcess(dict_OpenProcess)

    #------------------------------------>GetProcessHeap
    print("Value handle to the calling process's heap",hook_GetProcessHeap())

    #---------------------------------->Process32First, Process32Next
    TH32CS_SNAPPROCESS = 0x00000002
    hProcessSnap = ctypes.windll.kernel32.CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    print("handle process snap:",hProcessSnap)
    pe32 = PROCESSENTRY32(0)
    pe32.dwSize = ctypes.sizeof(pe32)
    print(pe32.dwSize)
    dict_Proccess32={
        "hSnapshot":hProcessSnap,
        "lppe":byref(pe32)
    }
    success=hook_Process32First(dict_Proccess32)
    while success:
        print(pe32.szExeFile)
        hook_Process32Next(dict_Proccess32)
    ctypes.windll.kernel32.CloseHandle(hProcessSnap)
    
    #--------------------------------->GetExitCodeProcess
    lpExitcode=DWORD()
    print("hpprocess",pi.hProcess)
    hProcess=ctypes.windll.kernel32.OpenProcess(0x1F0FFF, False, pid)     # access: PROCESS_ALL_ACCESS
    dict_GetExitCodeProcess={
        "hProcess":hProcess,#pi.hProcess,
        "lpExitCode":lpExitcode
    }
    print("exitcode",hook_GetExitCodeProcess(dict_GetExitCodeProcess))

    #------------------------------->WriteProcessMemory
    val=ctypes.c_uint32(100)
    hProcess=ctypes.windll.kernel32.OpenProcess(0x1F0FFF, False, pid)
    if hProcess==0:
        print(format_system_message(ctypes.windll.kernel32.GetLastError()))
    print("handle",hProcess)
    addr=ctypes.windll.kernel32.VirtualAllocEx(hProcess, 0, sizeof(val),0x00001000,4)           #MEM_COMMIT, PAGE_READ_WRITE
    print(hex(addr))

    dict_WriteProcessMemory={
        "hProcess":hProcess,
        "lpBaseAddress":addr,
        "lpBuffer": byref(val) ,  
        "nSize":sizeof(val),
        "lpNumberOfBytesWritten":0
    }
    hook_WriteProcessMemory(dict_WriteProcessMemory)

    #------------------------------------->ReadProcessMemory
    dict_ReadProcessMemory={
        "hProcess":hProcess,
        "lpBaseAddress":addr,
        "lpBuffer": byref(val) ,  
        "nSize":sizeof(val),
        "lpNumberOfBytesRead":0
    }
    hook_ReadProcessMemory(dict_ReadProcessMemory)
    print(val)

    #---------------------------------------->GetProcessId
    dict_GetProcessId={
        "Process":hProcess
    }
    print(hook_GetProcessId(dict_GetProcessId))
    
    dict_TerminateProcess={
    "hProcess": hProcess,
    "uExitCode":0
    }
    print("Terminates the current process ",hook_TerminateProcess(dict_TerminateProcess)) 
if __name__ == "__main__":
    main()
    


