import binascii

hex_str = "A8FFFFFF6E6B2000BB8E7A90D4C4D70100000000E00C00000000000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF488C0100FFFFFFFF000000000000000000000000000000002000000008000000506F6C6963696573F8FFFFFF086B0400"
hex_bytes = binascii.unhexlify(hex_str)
# print(hex_bytes)
# a=659456
# print(hex_bytes+a.to_bytes(4,'little'))
# import struct
# print(struct.pack('<I', int('0xa1000', base=16)))
# strs="nam".encode("hex")

# print(strs)
# # from dfwinreg import registry
with open("C:\\Users\\Admin\\AppData\\Local\\Temp\\MicrosoftEdgeDownloads\\3621051e-fc0f-47e9-abf3-0659b3cc7342\\test_shell (1).txt", 'rb+') as f:
    f.seek(0x63a0,0)
    f.write(hex_bytes)
#     #  registry_key =registry.WinRegistry(f)
#     #  print(registry_key.GetRootKey().GetSubkeyByIndex(1))
# # from dfwinreg import regf


# # key_path = 'HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion'

# # registry_key = registry.WinRegistry.OpenAndMapFile
# from dfwinreg import virtual 
# print(bytes([2]))