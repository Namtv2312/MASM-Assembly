def parse_File(fi,fo):
    arch=''
    os_file=''
    frmat=''
    from pathlib import Path   
    extension=''.join(Path(fi).suffixes)
    import lief,magic
    result1=lief.parse(fi)

    result2=magic.from_file(fi)

    if "None" not in str(result1):
        for line in (str(result1).split("\n")):
            if "Machine" in line:
                arch=line.split(":")[1][-6:]
        arr=[]
        for line in (str(result1).split("\n")):
            if "OS" in line:
                arr.append(line) 
        try:os_file=arr[0].split(":")[1][-12:]
        except:
            for line in (str(result1).split("\n")):
                if "Subsystem" in line:
                    arr.append(line)
            os_file=arr[-1].split(":")[1][-12:]    
        if "Mach-O" in   str(result2):
            frmat="Mach-O exe"
            os_file="MacOS"   
            if "x86_64" in str(result2):
                arch="x64"
            elif "ARM" in str(result2):
                arch="ARM"
            else:
                arch="x86"
        if "Windows" in str(result2):
            frmat="exe"
            os_file="Windows"
            if "x86-64" in str(result2):
                arch="x64"
            elif "ARM" in str(result2):
                arch="ARM"
            else:
                arch="x86"
        if "ELF" in str(result2):
            frmat="elf"
            os_file="linux"
            if "x86-64" in str(result2):
                arch="x64"
            elif "ARM" in str(result2):
                arch="ARM"
            else:
                arch="x86"
                
    else:
        if "Java" in str(result2):
            os_file="Android" 
            arch="Application"
            frmat="apk"
        elif "DOS" in str(result2):
            os_file="Windows"
            arch="8086"
            frmat="exe"
        elif "text" in str(result2):
            frmat="txt"
            os_file="Windows"
            arch="x64"
        else:  
            os_file="Not detect"
            arch=  "Not detect"
    myDict={
        "format":frmat,
        "os":os_file,
        "arch":arch
    }
    import json
    with open(fo,'w') as f:
        json.dump(myDict,f,ensure_ascii=False)
    import os
    clear=lambda: os.system('cls')
    clear()
    print("Phân tích thành công, kết quả trả về trong",fo)
def main():
    import argparse
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter
    ,description='''
    Chương trình kiếm tra định dạng file :
        -fi "đường dẫn file"
        -fo "đường dẫn file kết quả"
        1. Kết quả trả về dạng json, gồm các thông tin sau
        "format": "exe, elf, txt,..."
        "os": "windows, linux, android, macos..."
        "arch": "8086, x86, x64, ARM..."
        Trong đó: format là định dạng của file, os là hệ điều hành, arch là kiến trúc vi xử lý.
    Documentation: 
    ELF file format Structure: https://en.wikipedia.org/wiki/Executable_and_Linkable_Format
    List file signature:    https://en.wikipedia.org/wiki/List_of_file_signatures
    File command based LIBMAGIC: https://en.wikipedia.org/wiki/File_(command)

    '''
    ,usage='''
    main.py [-h] for help,
    ''',epilog="Cam on ban da lang nghe"
    ,exit_on_error=False)
    parser.add_argument('-fi',help="Nhap duong dan file", metavar="c:/path", required=True)
    parser.add_argument('-fo',help="Nhap duong dan file ket qua", metavar="d:/path",required=True)
    args=parser.parse_args()
    parse_File(args.fi, args.fo)
    # import magic as mg
    # print(mg.from_file("C:\Windows\System32\DriverStore\FileRepository\winusb.inf_amd64_ced441476847bd1a\winusb.sys"))
    # from os.path import abspath, dirname, join
    # path = join(dirname(abspath(__file__)), "", "data.json")
    # import subprocess
    # subprocess.run(["polyfile.exe",args.fi])
if __name__ == "__main__":
    main()
    # with open("D:\Download\Test.docx",'rb') as f:
    #     info = fleep.get(f.read(256))
    # print(info.type)  # prints ['raster-image']
    # print(info.extension)  # prints ['png']
    # print(info.mime)  # prints ['image/png']
    # print(info.type_matches("raster-image"))  # prints True
    # print(info.extension_matches("gif"))  # prints False
    # print(info.mime_matches("image/png"))  # prints True
    