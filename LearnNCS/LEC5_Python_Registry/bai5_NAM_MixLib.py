from yarp import Registry
import pyregf
import uuid
from typing import Union
import datetime as dt
import pytz

HKEY_CLASSES_ROOT = ''
HKEY_CURRENT_CONFIG = ''
HKEY_CURRENT_USER = ''
HKEY_LOCAL_MACHINE = ''
HKEY_PERFORMANCE_DATA = ''
HKEY_USERS = ''
hKey_root_id = uuid.uuid4()
hKey_map = {str(hKey_root_id):  HKEY_CURRENT_USER}
file_name = r'C:\Users\Admin\3D Objects\ntuser.dat'


def RegOpenKeyEx(params):
    '''
    Opens the specified registry key.
    '''
    try:
        hKey = params["hKey"]
        lpSubKey = params["lpSubKey"]
        ulOptions = params["ulOptions"]
        samDesired = params["samDesired"]
        phkResult = params["phkResult"]
        hKey_open_id = uuid.uuid4()
        hKey_map[str(hKey_open_id)] = hKey_map[str(hKey)].join(lpSubKey)
        params["phkResult"] = hKey_open_id
        print("OpenKey Success")
        return 0
    except:
        print("RegOpenKeyEx NOT success")
        return 1


def RegQueryInfoKey(params):
    '''
    Retrieves information about the specified registry key.
    '''
    hKey = params["hKey"]
    lpClass = params["lpClass"]
    lpcchClass = params["lpcchClass"]
    lpReserved = params["lpReserved"]
    lpcSubKeys = params["lpcSubKeys"]
    lpcbMaxSubKeyLen = params["lpcbMaxSubKeyLen"]
    lpcbMaxClassLen = params["lpcbMaxClassLen"]
    lpcValues = params["lpcValues"]
    lpcbMaxValueNameLen = params["lpcbMaxValueNameLen"]
    lpcbMaxValueLen = params["lpcbMaxValueLen"]
    lpcbSecurityDescriptor = params["lpcbSecurityDescriptor"]
    lpftLastWriteTime = params["lpftLastWriteTime"]
    key_path = hKey_map[str(hKey)]
    with open(file_name, "rb+") as fp:
        hive = Registry.RegistryHive(fp)
        # hive1=RegistryFile.HiveBin(fp)
        # hive1.get_size()
        # print(hive.registry_file.baseblock.get_hbins_data_size())
        # print(hive.registry_file.baseblock.get_filename().decode('raw_unicode_escape'))
        # print(hive.registry_file.baseblock.get_root_cell_offset())
        try:
            key_node = hive.find_key(key_path)
            print("lpClass: ", key_node.classname())
            print("lpcchClass:", key_node.key_node.get_classname_length())
            params["lpcSubKeys"] = key_node.subkeys_count()
            print("lpcSubKeys: ", key_node.subkeys_count())
            print("lpcbMaxSubKeyLen:",
                  key_node.key_node.get_largest_subkey_name_length())
            print("lpcbMaxClassLen",
                  key_node.key_node.get_largest_subkey_classname_length())
            print("lpcValues: ", key_node.values_count())
            print("lpcbMaxValueNameLen",
                  key_node.key_node.get_largest_value_name_length())
            print("lpcbMaxValueLen", key_node.key_node.get_largest_value_data_size())
            print("lpcbSecurityDescriptor",
                  key_node.key_node.get_key_security_offset())
            print("lpftLastWriteTime",
                  convert_wintime(key_node.key_node.get_last_written_timestamp()))
            fp.close()
            return 0
        except:
            print("RegQueryInfo NOT success")
            return 1


def RegEnumKeyEx(params):
    '''
    Enumerates the subkeys of the specified open registry key. The function retrieves information about one subkey each time it is called.
    '''
    hKey = params["hKey"]
    dwIndex = params["dwIndex"]
    lpName = params["lpName"]
    lpcchName = params["lpcchName"]
    lpReserved = params["lpReserved"]
    lpClass = params["lpClass"]
    lpcchClass = params["lpcchClass"]
    lpftLastWriteTime = params["lpftLastWriteTime"]
    key_path = hKey_map[str(hKey)]
    regf = pyregf.file()
    regf.open(file_name)
    try:
        print("Key number", dwIndex)
        key_path = hKey_map[str(hKey)]
        key_node = regf.get_root_key().get_sub_key_by_path(key_path).get_sub_key(dwIndex)
        print("lpName: ", key_node.get_name())
        print("lpcchName: ", len(str(key_node.get_name())))
        print("lpClass: ", key_node.get_class_name())
        print("lpcchClass: ", len(str(key_node.get_class_name())))
        print("lpftLastWriteTime:", convert_wintime(
            key_node.get_last_written_time_as_integer()))
        print('Enum Success')
        return 0
    except:
        print("RegEnum NOT success")
        return 1


def RegCloseKey(param):
    '''
    Closes a handle to the specified registry key.
    '''
    hKey = param["hKey"]
    try:
        del hKey_map[str(hKey)]
        print("CloseKey Success")
        return 0
    except:
        print("Closekey NOT succes")
        return 1


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

    # -------------------------> RegOpenKeyExA
    dict_RegOpenKeyEx = {
        "hKey": hKey_root_id,
        "lpSubKey": r'Software\Microsoft',
        "ulOptions": 0,
        "samDesired": 0xF003F,
        "phkResult": None
    }
    RegOpenKeyEx(dict_RegOpenKeyEx)
    # -------------------------> RegQueryInfoKey
    hQuery_id = dict_RegOpenKeyEx["phkResult"]
    dict_RegQueryInfoKey = {
        "hKey": hQuery_id,
        "lpClass": None,
        "lpcchClass": None,
        "lpReserved": None,
        "lpcSubKeys": None,
        "lpcbMaxSubKeyLen": None,
        "lpcbMaxClassLen": None,
        "lpcValues": None,
        "lpcbMaxValueNameLen": None,
        "lpcbMaxValueLen": None,
        "lpcbSecurityDescriptor": None,
        "lpftLastWriteTime": None
    }
    RegQueryInfoKey(dict_RegQueryInfoKey)
 # -------------------------> RegEnum
    for i in range(dict_RegQueryInfoKey["lpcSubKeys"]):
        dict_RegEnumKeyEx = {
            "hKey": hQuery_id,
            "dwIndex": (i),
            "lpName": None,
            "lpcchName": None,
            "lpReserved": None,
            "lpClass": None,
            "lpcchClass": None,
            "lpftLastWriteTime": None
        }
        #RegEnumKeyEx(dict_RegEnumKeyEx)

        # -------------------------> RegClose
    dict_RegCloseKey = {
        "hKey": hKey_root_id
    }
    RegCloseKey(dict_RegCloseKey)


if __name__ == "__main__":
    print(convert_wintime(31017765))
    main()
