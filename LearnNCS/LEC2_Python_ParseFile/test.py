# import magic    
# print(magic.libmagic.magic_buffer)
import polyfile
import lief
# from elf import Elf
# dataa=Elf.from_file("C:\\Users\\Admin\\Desktop\\gzip")
# print(dataa.header)
# dataa.magic
a=(lief.parse("C:\Python27\python.exe"))
for line in (str(a).split("\n")):
    if "Machine" in line:
        print(line.split(":")[1][-6:])
arr=[]
for line in (str(a).split("\n")):
    print(line)
    if "Subsystem" in line:
        arr.append(line)
print(arr[-1:])

