#!/usr/bin/python
# -*- coding: utf-8 -*-
from typing import Union
import datetime as dt
import pytz


REG_NONE = 0x00000000
REG_SZ = 0x00000001
REG_EXPAND_SZ = 0x00000002
REG_BINARY = 0x00000003
REG_DWORD = 0x00000004
REG_DWORD_LITTLE_ENDIAN = REG_DWORD
REG_DWORD_BIG_ENDIAN = 0x00000005
REG_LINK = 0x00000006
REG_MULTI_SZ = 0x00000007
REG_RESOURCE_LIST = 0x00000008
REG_FULL_RESOURCE_DESCRIPTOR = 0x00000009
REG_RESOURCE_REQUIREMENTS_LIST = 0x0000000a
REG_QWORD = 0x0000000b
REG_QWORD_LITTLE_ENDIAN = REG_QWORD

ValueTypes = {
    REG_NONE: 'REG_NONE',
    REG_SZ: 'REG_SZ',
    REG_EXPAND_SZ: 'REG_EXPAND_SZ',
    REG_BINARY: 'REG_BINARY',
    REG_DWORD: 'REG_DWORD',
    REG_DWORD_BIG_ENDIAN: 'REG_DWORD_BIG_ENDIAN',
    REG_LINK: 'REG_LINK',
    REG_MULTI_SZ: 'REG_MULTI_SZ',
    REG_RESOURCE_LIST: 'REG_RESOURCE_LIST',
    REG_FULL_RESOURCE_DESCRIPTOR: 'REG_FULL_RESOURCE_DESCRIPTOR',
    REG_RESOURCE_REQUIREMENTS_LIST: 'REG_RESOURCE_REQUIREMENTS_LIST',
    REG_QWORD: 'REG_QWORD'
}


def type_str(params: int):
    """Get, decode and return a value type (as a string)."""

    value_type = params
    if value_type in ValueTypes.keys():
        return ValueTypes[value_type]
    else:
        return hex(value_type)


def byte_str_to_int(params: bytes):
    return int(params[::-1].hex(), 16)


def convert_wintime(wintime: int, as_json=False) -> Union[dt.datetime, str]:
    """
    Get an integer containing a FILETIME date
    :param wintime: integer representing a FILETIME timestamp
    :param as_json: whether to return the date as string or not
    :return: datetime
    """
    # http://stackoverflow.com/questions/4869769/convert-64-bit-windows-date-time-in-python
    us = wintime / 10
    try:
        date = dt.datetime(1601, 1, 1, tzinfo=pytz.utc) + \
            dt.timedelta(microseconds=us)
    except OverflowError:
        # If date is too big, it is probably corrupted' let's return the smallest possible windows timestamp.
        date = dt.datetime(1601, 1, 1, tzinfo=pytz.utc)
    return date.isoformat() if as_json else date


def main():
    with open(r'C:\Users\Admin\Desktop\test_currentversion', "rb+") as fp:
        # Moving the file handle to 0th character
        fp.seek(0, 0)
        # read file header
        # read signature offset 0
        sig_head = fp.read(4)
        print("signarure:", sig_head)
        fp.seek(4, 0)
        # read primary sequence number
        pri_seq_num = fp.read(2)
        print("pri_seq_num:", int(pri_seq_num[::-1].hex(), 16))
        # Read Secondary sequence number
        fp.seek(8, 0)
        sec_seq_num = fp.read(4)
        print("Secondary sequence number", int(sec_seq_num[::-1].hex(), 16))
        # Read Last written timestamp
        fp.seek(12, 0)
        last_write_timestamp = fp.read(8)
        print("last write time", byte_str_to_int(last_write_timestamp))
        print(convert_wintime(byte_str_to_int(last_write_timestamp)).isoformat())
        # read major version
        fp.seek(20, 0)
        major_ver = fp.read(4)
        print("Major version:", byte_str_to_int(major_ver))
        # read minor version
        fp.seek(24, 0)
        minor_ver = fp.read(4)
        print("Minor version:", byte_str_to_int(minor_ver))
        # read file type
        fp.seek(28, 0)
        file_type = fp.read(4)
        print("File type:", "Primary file:0" if (
            not byte_str_to_int(file_type)) else byte_str_to_int(file_type))
        # read file format
        fp.seek(32, 0)
        file_format = fp.read(4)
        print("File formats:", "1: Direct memory load" if (
            byte_str_to_int(file_format)) else byte_str_to_int(file_format))
        # read root cell offset:
        fp.seek(36, 0)
        root_cell_offset = fp.read(4)
        print("Root cell offset:", byte_str_to_int(root_cell_offset))
        # read Hive bins data size
        fp.seek(40, 0)
        hive_bin_offset_data_size = byte_str_to_int(fp.read(4))
        print("Hive bins data size:", hive_bin_offset_data_size)
        # read Clustering factor:
        fp.seek(44, 0)
        clustering_factor = fp.read(4)
        print("Clustering factor:", byte_str_to_int(clustering_factor))
        # read file name:
        fp.seek(48, 0)
        file_name = fp.read(64)
        print("File name:", file_name.decode('raw_unicode_escape'))
        # read Checksum
        fp.seek(508)
        check_sum = fp.read(4)
        print("Check sum: ", byte_str_to_int(check_sum))
        # read Boot type:
        fp.seek(4088)
        boot_type = fp.read(4)
        print("Boot type: ", byte_str_to_int(boot_type))
        # read Boot recover
        fp.seek(4092, 0)
        boot_recover = fp.read(4)
        print("Boot recover:", byte_str_to_int(boot_recover))
        # Read Hive BIN
        # Caculate file offset of a root cell and number of  hive bin
        # numb_of_hive_bin=hive_bin_offset_data_size/4096
        # print("Number of Hive bin:",int(numb_of_hive_bin))
        # for i in range (1,2):#  ,int(numb_of_hive_bin)+1):
        size_of_cur_hive = 4096
        file_offset = 0
        # i=0
        # 8192:  #
        while file_offset < hive_bin_offset_data_size:
            # i+=1
            # print(i,".")
            file_offset += size_of_cur_hive
            print("FILE OFFSET:", file_offset)
            file_offet_off_root_cell = file_offset + \
                byte_str_to_int(root_cell_offset)
            print("file offset off root cell", file_offet_off_root_cell)
            """
            File offset of a root cell = 4096 + Root cell offset.
            This formula also applies to any other offset relative from the start of the hive bins data 
            (however, if such a relative offset is equal to 0xFFFFFFFF, it doesn't point anywhere).
            """
            # Read header HIVE BIN
            # read signature hive bin
            fp.seek(file_offset+0, 0)
            sig_hive_bin = fp.read(4)
            print("Hive bin signature:", sig_hive_bin)
            # read offset currnent hive bin from start of the hive bins data
            fp.seek(file_offset+4, 0)
            offset_hive_bin = fp.read(4)
            print("Offset current hive bin:", byte_str_to_int(offset_hive_bin))
            # read size of current hive bin in bytes:
            fp.seek(file_offset+8, 0)
            size_of_cur_hive = byte_str_to_int(fp.read(4))
            print("Size of current hive bin in bytes:", size_of_cur_hive)
            # read time stamp:
            fp.seek(file_offset+20, 0)
            time_stamp = fp.read(8)
            print("Time stamps:", byte_str_to_int(time_stamp))
            print(convert_wintime(byte_str_to_int(time_stamp)).isoformat())
            # read Spare( or MemAlloc)
            fp.seek(file_offset+28, 0)
            spare_memalloc = fp.read(4)
            print("Spare or (memalloc):", byte_str_to_int(spare_memalloc))
            """
            A hive bin size is multiple of 4096 bytes.
            The Spare field is used when shifting hive bins and cells in memory. In Windows 2000, the same field is called MemAlloc, it is used to track memory allocations for hive bins.
            A Timestamp in the header of the first hive bin acts as a backup copy of a Last written timestamp in the base block.
            """
            # Read hive bin cell
            while file_offet_off_root_cell < file_offset + size_of_cur_hive:
                # read size cell
                fp.seek(file_offet_off_root_cell, 0)
                cell_size = fp.read(4)
                print("Cell size", cell_size,
                      byte_str_to_int(cell_size)-(1 << 32))
                # Read Cell data value
                  
                # read signature
                fp.seek(file_offet_off_root_cell+4, 0)
                sig_cell_value = fp.read(2)
                print("Signature:", sig_cell_value)

                if (sig_cell_value == b'nk'):
                    # read name key
                    # read flag
                    fp.seek(file_offet_off_root_cell+6, 0)
                    flag_nk = fp.read(2)
                    print("Flag named key:", byte_str_to_int(flag_nk))
                    # read last written timestamp
                    fp.seek(file_offet_off_root_cell+8, 0)
                    last_write_time_nk = fp.read(8)
                    print("Last written timestamp:",
                          byte_str_to_int(last_write_time_nk))
                    print(convert_wintime(byte_str_to_int(
                        last_write_time_nk)).isoformat())
                    # read access bits
                    fp.seek(file_offet_off_root_cell+16, 0)
                    access_bits_nk = fp.read(4)
                    print("Access bits named key", access_bits_nk)
                    # read parrent key offset
                    fp.seek(file_offet_off_root_cell+20, 0)
                    parrent_key_offset = fp.read(4)
                    print("Parrent key offset:",
                          byte_str_to_int(parrent_key_offset))
                    # read number of subkeys:
                    fp.seek(file_offet_off_root_cell+24, 0)
                    numb_of_subkey = fp.read(4)
                    print("Number of subkeys:", byte_str_to_int(numb_of_subkey))
                    # read number of volatile subkeys
                    fp.seek(file_offet_off_root_cell+28, 0)
                    numb_of_volatile_subkeys = fp.read(4)
                    print("Number of volatile subkeys:",
                          byte_str_to_int(numb_of_volatile_subkeys))
                    # read sub keys list offset
                    fp.seek(file_offet_off_root_cell+32, 0)
                    subkeys_list_offset = fp.read(4)
                    print("Sub keys list offset:",
                          byte_str_to_int(subkeys_list_offset))
                    # read volatile sub keys list offset
                    fp.seek(file_offet_off_root_cell+36, 0)
                    volatile_subkeys_list_offset = fp.read(4)
                    print("Volatile sub kyes list offset:",
                          byte_str_to_int(volatile_subkeys_list_offset))
                    # read number of values:
                    fp.seek(file_offet_off_root_cell+40, 0)
                    numb_of_values_nk = fp.read(4)
                    print("Number of values named key:",
                          byte_str_to_int(numb_of_values_nk))
                    # read values list offset
                    fp.seek(file_offet_off_root_cell+44, 0)
                    values_list_offset = fp.read(4)
                    print("Values list offset:",
                          byte_str_to_int(values_list_offset))
                    # read security key offset:
                    fp.seek(file_offet_off_root_cell+48, 0)
                    security_key_offset = fp.read(4)
                    print("Security key offset:",
                          byte_str_to_int(security_key_offset))
                    # read class name offset
                    fp.seek(file_offet_off_root_cell+52, 0)
                    class_name_offset = fp.read(4)
                    print("Class name offset:",
                          byte_str_to_int(class_name_offset))
                    # read larget subkey name size:
                    fp.seek(file_offet_off_root_cell+56, 0)
                    largest_subkey_name_length = fp.read(4)
                    print("Largest sub key name size",
                          byte_str_to_int(largest_subkey_name_length))
                    # read largest sub key class name size
                    fp.seek(file_offet_off_root_cell+60, 0)
                    largest_subkey_class_name_size = fp.read(4)
                    print("Largest sub key class name size",
                          byte_str_to_int(largest_subkey_class_name_size))
                    # READ largest value name size:
                    fp.seek(file_offet_off_root_cell+64, 0)
                    largest_value_name_size = fp.read(4)
                    print("Largest value name size:",
                          byte_str_to_int(largest_value_name_size))
                    # read workvar
                    fp.seek(file_offet_off_root_cell+72, 0)
                    work_Var = fp.read(4)
                    print("WorkVar:", byte_str_to_int(work_Var))
                    # read keyname size
                    fp.seek(file_offet_off_root_cell+76, 0)
                    key_name_size = fp.read(2)
                    print("Key name size:", byte_str_to_int(key_name_size))
                    # read key name string
                    fp.seek(file_offet_off_root_cell+80, 0)
                    key_name_strings = fp.read(byte_str_to_int(key_name_size))
                    print("Key names strings:", key_name_strings)

                elif (sig_cell_value == b'vk'):
                    # read name length
                    fp.seek(file_offet_off_root_cell+6, 0)
                    value_name_size_vk = fp.read(2)
                    print("Value name size:", byte_str_to_int(value_name_size_vk))
                    # read data size
                    fp.seek(file_offet_off_root_cell+8, 0)
                    data_size_vk = fp.read(4)
                    print("Data size:", byte_str_to_int(data_size_vk))
                    # read data offset
                    fp.seek(file_offet_off_root_cell+12, 0)
                    data_offset_vk = fp.read(4)
                    print("Data offset:", byte_str_to_int(data_offset_vk))
                    # read dta type
                    fp.seek(file_offet_off_root_cell+16, 0)
                    data_type_vk = fp.read(4)
                    print("Data type:", type_str(
                        byte_str_to_int(data_type_vk)))
                    #read Data:
                    fp.seek(file_offset+byte_str_to_int(data_offset_vk)+4,0)
                    data_vk=fp.read(byte_str_to_int(data_size_vk))
                  #   if type_str(byte_str_to_int(data_type_vk))=="REG_SZ":
                  #       print("Data value key:",data_vk.decode('raw_unicode_escape'))
                  #   else:
                  #       print("Data value key:",data_vk)
                    # read flag:
                    fp.seek(file_offet_off_root_cell+20, 0)
                    flag_vk = fp.read(2)
                    print("Flag value key:", byte_str_to_int(flag_vk))
                    # read spare
                    fp.seek(file_offet_off_root_cell+22, 0)
                    spare_vk = fp.read(2)
                    print("Spare vk:", byte_str_to_int(spare_vk))
                    # read value name string:
                    fp.seek(file_offet_off_root_cell+24, 0)
                    value_name_vk = fp.read(
                        byte_str_to_int(value_name_size_vk))
                    print("Value name string vk:", value_name_vk)

                elif (sig_cell_value == b'sk'):
                    # read Flink Previous security key offset
                    fp.seek(file_offet_off_root_cell+8, 0)
                    flink_sk = fp.read(4)
                    print("Previous security key offset: Flink",
                          byte_str_to_int(flink_sk))
                    # read Blink Next security key offset
                    fp.seek(file_offet_off_root_cell+12, 0)
                    blink_sk = fp.read(4)
                    print("Next security key offset: Blink:",
                          byte_str_to_int(blink_sk))
                    # read Reference count:
                    fp.seek(file_offet_off_root_cell+16, 0)
                    reference_count_sk = fp.read(4)
                    print("Reference count:", byte_str_to_int(reference_count_sk))
                    # read nt security descriptor size
                    fp.seek(file_offet_off_root_cell+20, 0)
                    nt_sec_des_size = fp.read(4)
                    print("NT security descriptor size:",
                          byte_str_to_int(nt_sec_des_size))
                    # read NT security descriptor:
                    fp.seek(file_offet_off_root_cell+24, 0)
                    nt_sec_descrb = fp.read(byte_str_to_int(nt_sec_des_size))
                    print("NT security descriptor :", nt_sec_descrb)
                # READ subkeys list
                elif (sig_cell_value == b'lh'):
                    # read number of element:
                    fp.seek(file_offet_off_root_cell+6, 0)
                    numb_of_elements_lh = fp.read(2)
                    print("Numbers of elements hash leaf( lh )",
                          byte_str_to_int(numb_of_elements_lh))
                    # read list elements:
                    # read key node offset:
                    fp.seek(file_offet_off_root_cell+8, 0)
                    key_node_offset_lh = fp.read(4)
                    print("Key node offset Hash leaf:",
                          byte_str_to_int(key_node_offset_lh))
                    # read name hash
                    fp.seek(file_offet_off_root_cell+12, 0)
                    name_hash_lh = fp.read(4)
                    print("Name hash hash leaf:", name_hash_lh)
                elif (sig_cell_value == b'lf'):
                    # read number of elements
                    fp.seek(file_offet_off_root_cell+6, 0)
                    numb_of_elements_lf = fp.read(2)
                    print("Numbers of elements Fast leaf( lf )",
                          byte_str_to_int(numb_of_elements_lf))
                    # read list element:
                    fp.seek(file_offet_off_root_cell+8, 0)
                    key_node_offset_lf = fp.read(4)
                    print("Key node offset Fast leaf:",
                          byte_str_to_int(key_node_offset_lf))
                    # read name hint:
                    fp.seek(file_offet_off_root_cell+12, 0)
                    name_hint_lf = fp.read(4)
                    print("|Name hint fast leaf:", name_hint_lf)
                elif (sig_cell_value == b'li'):
                    # read number of elements
                    fp.seek(file_offet_off_root_cell+6, 0)
                    numb_of_elements_li = fp.read(2)
                    print("Numbers of elements Index leaf( li )",
                          byte_str_to_int(numb_of_elements_li))
                    # read list element:
                    fp.seek(file_offet_off_root_cell+8, 0)
                    key_node_offset_li = fp.read(4)
                    print("Key node offset Index leaf:",
                          byte_str_to_int(key_node_offset_li))
                elif (sig_cell_value == b'ri'):
                    # read number of elements
                    fp.seek(file_offet_off_root_cell+6, 0)
                    numb_of_elements_ri = fp.read(2)
                    print("Numbers of elements Index root( ri )",
                          byte_str_to_int(numb_of_elements_ri))
                    # read list element:
                    fp.seek(file_offet_off_root_cell+8, 0)
                    subkeys_list_offset_ri = fp.read(4)
                    print("Subkey list offset index root:",
                          byte_str_to_int(subkeys_list_offset_ri))
                file_offet_off_root_cell += abs(
                    byte_str_to_int(cell_size)-(1 << 32))


if __name__ == "__main__":
    main()


# import pyregf
# # print(pyregf.get_version())
# # regf_file=pyregf.file.root_key
# # # regf_file.open("C:\\Users\\Admin\\3D Objects\\NTUSER.DAT")
# # print(regf_file)
# # # key = regf_file.get_key_by_path("\\Software\\Microsoft\\Windows\\CurrentVersion")
# # # print(key)
# # # a=open("C:\\Users\\Admin\\3D Objects\\NTUSER.DAT",mode="w")
# # # a.write("ok")
# # # regf_file.get_root_key()
# # # reg_f=pyregf.file()
# # # reg_file_ob=reg_f.open_file_object(regf_file)
# # # # help(pyregf)
# # # # help(pyregf.file)
# # # # print(regf_file.open_file_object(regf_file.get_root_key()))
# # # # print(key.get_name())
# # # print(regf_file.get_root_key().get_name())
# # # print((reg_file_ob))
# # # regf_file.close()
# from regipy.utils import convert_wintime
# from regipy.registry import RegistryHive
# reg = RegistryHive('C:\\Users\\Admin\\3D Objects\\NTUSER.DAT')

# # Iterate over a registry hive recursively:
# for sk in reg.get_key('Software').iter_subkeys():
#     print(sk.name, convert_wintime(sk.header.last_modified).isoformat())
# print( reg.get_hbin_at_offset(5555))
# # for entry in reg.recurse_subkeys(as_json=False):
# #     print(entry)
# # import hive
# # import uuid
# # a=uuid.uuid1()
# # uuid(1)==a
