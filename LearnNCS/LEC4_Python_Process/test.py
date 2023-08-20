import pefile

def is_dll_or_exe(filepath):
    try:
        pe = pefile.PE(filepath)
        if pe.FILE_HEADER.IMAGE_FILE_DLL:
            return "DLL"
        else:
            return "Executable"
    except pefile.PEFormatError:
        return "Not a PE file"

filepath = "D:\\masm32\\bin\\rcdll.dll"
result = is_dll_or_exe(filepath)
print(result)