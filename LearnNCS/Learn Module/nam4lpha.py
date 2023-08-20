# import uuid

# # Create a mapping object using a dictionary
# mapping = {}

# # Create a Python object
# my_obj = "Hello, world!"

# # Create a PyHandle to the object
# my_handle = id(my_obj)

# # Create a UUID
# my_uuid = uuid.uuid4()

# # Map the UUID to the PyHandle in the mapping object
# mapping[str(my_uuid)] = my_handle

# # Access the object using the UUID
# obj_handle = mapping[str(my_uuid)]
# if obj_handle:
#     obj = object.__getattribute__(object, "__repr__")(object.__getattribute__(object, "__int__")(obj_handle))
#     print(obj)  # Output: "Hello, world!"

# # Close the handle
# my_obj = None
# mapping.pop(str(my_uuid))
from regipy import RegistryHive
hive=RegistryHive(r'C:\Users\Admin\Desktop\test_shell')
print(hive.get_key(r'Associations'))

for entry in hive.recurse_subkeys(as_json=True):
    print(entry)


# # create a UUID
# obj_uuid = uuid.uuid4()
# some_object="nam"
# # map the object to the UUID
# obj_map = {str(obj_uuid): some_object}
# obj_map["nam"]="nam"

# # retrieve the object using the UUID
# retrieved_obj = obj_map[str(obj_uuid)]
# print(retrieved_obj,obj_map["nam"])