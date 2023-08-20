from yarp import Registry
file_name=r'C:\Users\Admin\Desktop\test_shell'
import ctypes
a=ctypes.c_int()
print(ctypes.windll.kernel32.GetSystemTimeAsFileTime())
print(a.value)
with open(file_name, "rb+") as fp:
            hive = Registry.RegistryHive(fp)
            # hive1=RegistryFile.HiveBin(fp)
            # hive1.get_size()
            print(hive.registry_file.baseblock.get_hbins_data_size())
            print(hive.registry_file.baseblock.get_filename().decode('raw_unicode_escape'))
            print(hive.registry_file.baseblock.get_root_cell_offset())
            print(hive.registry_file.baseblock.calculate_checksum())
            print(hive.registry_file.baseblock.get_checksum())
            print(hive.find_key(r'App Paths').get_cell(2072))
# import pyregf
# regf = pyregf.file()
# regf.open(file_name)
# key_node=regf.get_root_key().get_sub_key_by_path(r'Associations\UrlAssociations').get_sub_key(85)
# print("lpName: ",key_node.get_name())
# print("lpcchName: ",len(str(key_node.get_name())))
# print("lpClass: ",key_node.get_class_name())
# print("lpcchClass: ",len(str(key_node.get_class_name())))
# print("lpftLastWriteTime:",(key_node.get_last_written_time_as_integer()))
# print('Enum Success')
# import pyregf
# import binascii

# def byte_str_to_int(params: bytes):
#     return int(params[::-1].hex(), 16)

# hive_filename = "C:\\Users\\Admin\\Desktop\\test_currentversion"
# regf = pyregf.file()
# try:
#     regf.open(hive_filename)
# except OSError as e:
#     print("Open File error, not detect format hive file,", e.args)
#     exit()
# root_key_obj = regf.get_root_key()
# numb_of_subkey = root_key_obj.get_number_of_sub_keys()

# key_test = root_key_obj.get_sub_key(0)
# print(key_test.get_name())
# off_set_kt = key_test.get_offset()
# print(off_set_kt)
# numb_of_subkey = key_test.get_number_of_sub_keys()
# print(numb_of_subkey)
# with open(hive_filename, "rb+") as fp:
#     fp.seek(off_set_kt+20, 0)
#     fp.write(bytes([numb_of_subkey+1]))
#     offset_subkeys = off_set_kt+28
#     fp.seek(offset_subkeys)
#     offset_subkey_list = byte_str_to_int(fp.read(4))+4096
#     print(offset_subkey_list)
#     fp.seek(offset_subkey_list+6, 0)
#     numb_element_sublist = byte_str_to_int(fp.read(2))
#     fp.seek(offset_subkey_list+6, 0)
#     fp.write(bytes([numb_element_sublist+1]))
#     fp.seek(offset_subkey_list)
#     size_of_list_ = abs(byte_str_to_int(fp.read(4))-(1 << 32))
#     fp.seek(offset_subkey_list)
#     buffer_tmp = fp.read(size_of_list_)
#     print(buffer_tmp)
#     nk_record_rawdata = binascii.unhexlify("A8FFFFFF6E6B2000E6BF708F5340D90102000000200000000100000000000000C8EE0900FFFFFFFF00000000FFFFFFFFF0010000FFFFFFFF0E0000000000000000000000000000000000000008000000576562636865636B")
#     print(nk_record_rawdata)
#     fp.seek(0,2)
#     fp.seek(fp.tell()-len(nk_record_rawdata),0)
#     fp.write(nk_record_rawdata)
#     # print(f.tell())
#     off_set_nk=fp.tell()-len(nk_record_rawdata)-4096
#     # print(off_set_nk)
#     buffer_tmp=buffer_tmp+off_set_nk.to_bytes(4,'little')+"Webc".encode("utf-8")
#     fp.seek(fp.tell()-len(nk_record_rawdata)-len(buffer_tmp),0)
#     fp.write(buffer_tmp)

    
