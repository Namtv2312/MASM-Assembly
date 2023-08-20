import ctypes
from ctypes import windll
from ctypes.wintypes import DWORD, HKEY

def hook_RegCloseKey(params):
    '''
    Closes a handle to the specified registry key.
    '''
    try:
        hKey=params["hKey"]
        res=ctypes.windll.kernel32.RegCloseKey(hKey) 
        if(res):
            print("RegCloseKey Error: ",format_system_message(res))
        else:   
            print("RegCloseKey OK");    
            return 0
    except Exception as e:
        print("RegCloseKey Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")
    
def hook_RegOpenKeyEx(params):
    '''
    Opens the specified registry key. Note that key names are not case sensitive.
    '''
    try:
        hKey=params["hKey"]
        lpSubKey=params["lpSubKey"]
        ulOptions=params["ulOptions"]
        samDesired=params["samDesired"]
        phkResult=params["phkResult"]
        if str(lpSubKey).isascii():
            res= ctypes.windll.advapi32.RegOpenKeyExA(hKey,lpSubKey,ulOptions,samDesired,phkResult)
            if(res):
                print("RegOpenKeyEx Error: ",format_system_message(res))
                return res
            else:
                print("RegOpenKeyEx OK")
                return 0
        else:
            res= ctypes.windll.advapi32.RegOpenKeyExW(hKey,lpSubKey,ulOptions,samDesired,phkResult)
            if(res):
                print("RegOpenKeyEx Error: ",format_system_message(res))
                return res
            else:
                print("RegOpenKeyEx OK")
                return 0
    except Exception as e:
        print("RegOpenKeyEx Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

def hook_RegCreateKeyEx(params):
    '''
    Creates the specified registry key. If the key already exists, the function opens it. Note that key names are not case sensitive.
    '''
    try:
        hKey=params["hKey"]
        lpSubKey=params["lpSubKey"]
        Reserved=params["Reserved"]
        lpClass=params["lpClass"]
        dwOptions=params["dwOptions"]
        samDesired=params["samDesired"]
        lpSecurityAttributes=params["lpSecurityAttributes"]
        phkResult=params["phkResult"]
        lpdwDisposition=params["lpdwDisposition"]
        if str(lpSubKey).isascii() | str(lpClass).isascii():
            res= ctypes.windll.kernel32.RegCreateKeyExA(hKey,lpSubKey,Reserved,lpClass,dwOptions, samDesired,lpSecurityAttributes,phkResult,lpdwDisposition)
            if(res):
                print("RegCreateKeyEx Error: ",format_system_message(res))
                return res
            else:
                print("RegCreateKeyEx OK")
                return 0
        else:
            res= ctypes.windll.kernel32.RegCreateKeyExW(hKey,lpSubKey,Reserved,lpClass,dwOptions, samDesired,lpSecurityAttributes,phkResult,lpdwDisposition)
            if(res):
                print("RegCreateKeyEx Error: ",format_system_message(res))
                return res
            else:
                print("RegCreateKeyEx OK")
                return 0
    except Exception as e:
        print("RegCreateKeyEx Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

def hook_RegEnumKeyEx(params):
    '''
    Enumerates the subkeys of the specified open registry key. The function retrieves information about one subkey each time it is called.
    '''
    try: 
        hKey= params["hKey"]
        dwIndex= params["dwIndex"]
        lpName= params["lpName"]
        lpcchName= params["lpcchName"]
        lpReserved= params["lpReserved"]
        lpClass= params["lpClass"]
        lpcchClass= params["lpcchClass"]
        lpftLastWriteTime= params["lpftLastWriteTime"]
        if str(lpName).isascii() | str(lpClass).isascii():
            res=ctypes.windll.kernel32.RegEnumKeyExA(hKey,dwIndex,lpName,lpcchName,lpReserved,lpClass,lpcchClass,lpftLastWriteTime)
            if(res):
                print("RegEnumKeyEx Error: ",format_system_message(res))
                return res
            else:
                print("RegEnumKeyEx OK")
                return 0
        else:
            res=ctypes.windll.kernel32.RegEnumKeyExW(hKey,dwIndex,lpName,lpcchName,lpReserved,lpClass,lpcchClass,lpftLastWriteTime)
            if(res):
                print("RegEnumKeyEx Error: ",format_system_message(res))
                return res
            else:
                print("RegEnumKeyEx OK")
                return 0
    except Exception as e:
        print("RegEnumKeyEx Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

def hook_RegCreateKey(params):
    '''
    Creates the specified registry key. If the key already exists in the registry, the function opens it.
    '''
    try:
        hKey=params["hKey"]
        lpSubKey=params["lpSubKey"]
        phkResult=params["phkResult"]
        if str(lpSubKey).isascii():
            res= ctypes.windll.advapi32.RegCreateKeyA(hKey, lpSubKey, phkResult)
            if(res):
                print("RegCreateKey Error: ",format_system_message(res))
                return res
            else:
                print("RegCreateKey OK")
                return 0
        else:
            res= ctypes.windll.advapi32.RegCreateKeyW(hKey, lpSubKey, phkResult)
            if(res):
                print("RegCreateKey Error: ",format_system_message(res))
                return res
            else:
                print("RegCreateKey OK")
                return 0
    except Exception as e:
        print("RegCreateKey Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

def hook_RegOpenKey(params):
    '''
    Opens the specified registry key.
    '''
    try:
        hKey=params["hKey"]
        lpSubKey=params["lpSubKey"]
        phkResult=params["phkResult"]
        if str(lpSubKey).isascii():
            res= ctypes.windll.advapi32.RegOpenKeyA(hKey, lpSubKey, phkResult)
            if(res):
                print("RegOpenKey Error: ",format_system_message(res))
                return res
            else:
                print("RegOpenKey OK")
                return 0
        else:
            res= ctypes.windll.advapi32.RegOpenKeyW(hKey, lpSubKey, phkResult)
            if(res):
                print("RegOpenKey Error: ",format_system_message(res))
                return res
            else:
                print("RegOpenKey OK")
                return 0
    except Exception as e:
        print("RegOpenKey Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

def hook_RegQueryInfoKey(params):
    '''
    Retrieves information about the specified registry key.
    '''
    try:
        hKey=params["hKey"]
        lpClass=params["lpClass"]
        lpcchClass=params["lpcchClass"]
        lpReserved=params["lpReserved"]
        lpcSubKeys=params["lpcSubKeys"]
        lpcbMaxSubKeyLen=params["lpcbMaxSubKeyLen"]
        lpcbMaxClassLen=params["lpcbMaxClassLen"]
        lpcValues=params["lpcValues"]
        lpcbMaxValueNameLen=params["lpcbMaxValueNameLen"]
        lpcbMaxValueLen=params["lpcbMaxValueLen"]
        lpcbSecurityDescriptor=params["lpcbSecurityDescriptor"]
        lpftLastWriteTime=params["lpftLastWriteTime"]
        if str(lpClass).isascii():
            res= ctypes.windll.kernel32.RegQueryInfoKeyA(hKey, lpClass,lpReserved,lpcchClass, lpcSubKeys, lpcbMaxSubKeyLen,lpcbMaxClassLen,lpcValues,lpcbMaxValueNameLen, lpcbMaxValueLen,lpcbSecurityDescriptor, lpftLastWriteTime)
            if(res):
                print("RegQueryInfoKey Error: ",format_system_message(res))
                return res
            else:
                print("RegQueryInfoKey OK")
                return 0
        else:
            res= ctypes.windll.kernel32.RegQueryInfoKeyW(hKey, lpClass,lpReserved,lpcchClass, lpcSubKeys, lpcbMaxSubKeyLen,lpcbMaxClassLen,lpcValues,lpcbMaxValueNameLen, lpcbMaxValueLen,lpcbSecurityDescriptor, lpftLastWriteTime)
            if(res):
                print("RegQueryInfoKey Error: ",format_system_message(res))
                return res
            else:
                print("RegQueryInfoKey OK")
                return 0
    except Exception as e:
        print("RegQueryInfoKey Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

def hook_RegDeleteKey(params):
    '''
    Deletes a subkey and its values. Note that key names are not case sensitive.
    '''
    try:
        hKey=params["hKey"]
        lpSubkey=params["lpSubkey"]
        if str(lpSubkey).isascii():
            res= ctypes.windll.advapi32.RegDeleteKeyA(hKey, lpSubkey)
            if(res):
                print("RegDeleteKey Error: ",format_system_message(res))
                return res
            else:
                print("RegDeleteKey OK")
                return 0
        else:
            res= ctypes.windll.advapi32.RegDeleteKeyW(hKey, lpSubkey)
            if(res):
                print("RegDeleteKey Error: ",format_system_message(res))
                return res
            else:
                print("RegDeleteKey OK")
                return 0
    except Exception as e:
        print("RegDeleteKey Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

def hook_RegSetValueEx(params):
    '''
    Sets the data and type of a specified value under a registry key.
    '''
    try: 
        hKey=params["hKey"]
        lpValueName=params["lpValueName"]
        Reserved=params["Reserved"]
        dwType=params["dwType"]
        lpData=params["lpData"]
        cbData=params["cbData"]
        if str(lpValueName).isascii():
            res= ctypes.windll.kernel32.RegSetValueExA(hKey,lpValueName, Reserved, dwType, lpData, cbData)
            if(res):
                print("RegSetValue Error: ",format_system_message(res))
                return res
            else:
                print("RegSetValue OK")
                return 0
        else:
            res= ctypes.windll.kernel32.RegSetValueExW(hKey,lpValueName, Reserved, dwType, lpData, cbData)
            if(res):
                print("RegSetValue Error: ",format_system_message(res))
                return res
            else:
                print("RegSetValue OK")
                return 0
    except Exception as e:
        print("RegSetValue Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

def hook_RegDeleteValue(params):
    '''
    Removes a named value from the specified registry key. Note that value names are not case sensitive.
    '''
    try:
        hKey=params["hKey"]
        lpValueName=params["lpValueName"]
        if str(lpValueName).isascii():
            res= ctypes.windll.kernel32.RegDeleteValueA(hKey,lpValueName)
            if(res):
                print("RegDeleteValue Error: ",format_system_message(res))
                return res
            else:
                print("RegDeleteValue OK")
                return 0
        else:
            res= ctypes.windll.kernel32.RegDeleteValueW(hKey,lpValueName)
            if(res):
                print("RegDeleteValue Error: ",format_system_message(res))
                return res
            else:
                print("RegDeleteValue OK")
                return 0
    except Exception as e:
        print("RegDeleteValue Error",format_system_message(ctypes.windll.kernel32.GetLastError()),str(e),"error")

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

def print_help():
    import textwrap
    print(textwrap.dedent('''
    Chương trình thao tác với Registry
    Các Function có chức năng tương tự Windows API
    Đầu vào đầu ra tương tự, đầu vào là 1 dict chứa các đối số,...
    Có khả năng xử lý theo handle file
    RegCloseKey
    RegOpenKeyEx
    RegCreateKeyEx
    RegEnumKeyEx
    RegCreateKey
    RegOpenKey
    RegQueryInfoKey
    RegDeleteKey
    RegSetValueEx
    RegDeleteValue
    --------------------------------------------------------------------------------------------
    ''')) 

def main():
    print_help()
    print("TESTCASE EXAMPLE")

    #-------------------------> RegOpenKeyExA
    HKEY_CURRENT_USER = 0x80000001
    key = ctypes.c_int(HKEY_CURRENT_USER)
    KEY_QUERY_VALUE = 0x1
    key_handle= HKEY()
    key_handle1= HKEY()
    dict_RegOpenKeyEx={
        "hKey":key,
        "lpSubKey":"Software\Microsoft\Windows\CurrentVersion\Run".encode('utf-8'),
        "ulOptions":0,
        "samDesired":0xF003F,
        "phkResult":ctypes.byref(key_handle)
    }
    hook_RegOpenKeyEx(dict_RegOpenKeyEx)

    #-------------------------->RegCloseKey
    dict_RegCloseKey={
        "hKey":key_handle
    }
    hook_RegCloseKey(dict_RegCloseKey)

    #--------------------------->RegCreateKeyEx
    dict_RegCreateKeyEx={
        "hKey":key,
        "lpSubKey":"Software\\abcd".encode("utf-8"),
        "Reserved":0,
        "lpClass":  None,
        "dwOptions":0,
        "samDesired":0x20019 | 0x20006,
        "lpSecurityAttributes":None,
        "phkResult":ctypes.byref(key_handle1),
        "lpdwDisposition":None
    }
    hook_RegCreateKeyEx(dict_RegCreateKeyEx)

    #---------------------------------------->RegQueryInfoKey
    subkey_cont=DWORD()
    subkey_len=DWORD()
    dict_RegQueryInfoKey={
        "hKey":key_handle,
        "lpClass":None,
        "lpcchClass":None,
        "lpReserved":None,
        "lpcSubKeys":ctypes.byref(subkey_cont),
        "lpcbMaxSubKeyLen":ctypes.byref(subkey_len),
        "lpcbMaxClassLen":None,
        "lpcValues":None,
        "lpcbMaxValueNameLen":None,
        "lpcbMaxValueLen":None,
        "lpcbSecurityDescriptor":None,
        "lpftLastWriteTime":None
    }
    hook_RegQueryInfoKey(dict_RegQueryInfoKey)

    #------------------------------->RegEnumKeyEx
    SubKeyName = ctypes.create_string_buffer(subkey_len.value + 1)
    subkey_namelen=DWORD()

    for i in range(subkey_cont.value):
        dict_RegEnumKeyEx={
        "hKey":key_handle,
        "dwIndex":DWORD(i),
        "lpName":ctypes.byref(SubKeyName),
        "lpcchName":ctypes.byref(subkey_namelen),
        "lpReserved":None,
        "lpClass":None,
        "lpcchClass":None,
        "lpftLastWriteTime":None
    }
        subkey_namelen.value=subkey_len.value+1
        hook_RegEnumKeyEx(dict_RegEnumKeyEx)

    #---------------------------------->RegCreateKey
    dict_RegCreateKey={
        "hKey":key,
        "lpSubKey":"Software\\abcde".encode("utf-8"),
        "phkResult":ctypes.byref(key_handle)
    }
    hook_RegCreateKey(dict_RegCreateKey)

    #---------------------------------------->RegOpenKey
    dict_RegOpenKey={
        "hKey":key_handle,
        "lpSubKey":"ok".encode("utf-8"),
        "phkResult":ctypes.byref(key_handle1)
    }
    hook_RegOpenKey(dict_RegOpenKey)
  
    #-------------------------------------->RegDeleteKey
    dict_RegDeleteKey={
        "hKey":key,
        "lpSubkey":"Software\\nammmm".encode("utf-8")
    }
    hook_RegDeleteKey(dict_RegDeleteKey)

    #------------------------------->RegSetValueEx
    dict_RegSetValueEx={
        "hKey":key_handle,
        "lpValueName":"kkkk",
        "Reserved":0,
        "dwType":0,
        "lpData":"nam",
        "cbData":5
    }
    hook_RegSetValueEx(dict_RegSetValueEx)

    #---------------------------------->RegDeleteValue
    dict_RegDeleteValue={
        "hKey":key_handle,
        "lpValueName":"kkkk"
    }
    hook_RegDeleteValue(dict_RegDeleteValue)
if __name__ == "__main__":
    main()
    


