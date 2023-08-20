import string
import six
my_string = "tran van nam"
if isinstance(my_string, six.string_types):
    print('The string is Unicode')
def is_ascii(s):
    return all(ord(c) < 128 for c in s)
if my_string.isascii():
    print("The ansi")