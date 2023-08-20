import pyregf
import binascii

def byte_str_to_int(params: bytes):
    return int(params[::-1].hex(), 16)

hive_filename = "C:\\Users\\Admin\\Desktop\\test_currentversion"
regf = pyregf.file()
try:
    regf.open(hive_filename)
except OSError as e:
    print("Open File error, not detect format hive file,", e.args)
    exit()
root_key_obj = regf.get_root_key()
numb_of_subkey = root_key_obj.get_number_of_sub_keys()

key_test = root_key_obj.get_sub_key(0)
print(key_test.get_name())
off_set_kt = key_test.get_offset()
print(off_set_kt)
numb_of_subkey = key_test.get_number_of_sub_keys()
print(numb_of_subkey)
with open(hive_filename, "rb+") as fp:
    fp.seek(off_set_kt+20, 0)
    fp.write(bytes([numb_of_subkey+1]))
    offset_subkeys = off_set_kt+28
    fp.seek(offset_subkeys)
    offset_subkey_list = byte_str_to_int(fp.read(4))+4096
    print(offset_subkey_list)
    fp.seek(offset_subkey_list+6, 0)
    numb_element_sublist = byte_str_to_int(fp.read(2))
    fp.seek(offset_subkey_list+6, 0)
    fp.write(bytes([numb_element_sublist+1]))
    fp.seek(offset_subkey_list)
    size_of_list_ = abs(byte_str_to_int(fp.read(4))-(1 << 32))
    fp.seek(offset_subkey_list)
    buffer_tmp = fp.read(size_of_list_)
    print(buffer_tmp)
with open(hive_filename, 'ab') as f:
    nk_record_rawdata = binascii.unhexlify("A8FFFFFF6E6B2000E6BF708F5340D90102000000200000000100000000000000C8EE0900FFFFFFFF00000000FFFFFFFFF0010000FFFFFFFF0E0000000000000000000000000000000000000008000000576562636865636B")
    print(nk_record_rawdata)
    f.write(nk_record_rawdata)
    print(f.tell())
    off_set_nk=f.tell()-len(nk_record_rawdata)-4096
    print(off_set_nk)
    buffer_tmp=buffer_tmp+off_set_nk.to_bytes(4,'little')+"Webc".encode("utf-8")
    f.write(buffer_tmp)

    
