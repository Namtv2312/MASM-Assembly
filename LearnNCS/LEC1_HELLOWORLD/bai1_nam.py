def AddStringsF(dict_val:dict):
    # results= ''.join(str(val) for val in dict_val.values())
    results=''.join([dict_val['str1'],dict_val["str2"]])
    print(results) 
def CopyStringF(dict_val:dict):
    print("Copy string thu nhat sang String thu 2")
    strings1=list(dict_val.values())[0]
    strings2=list(dict_val.values())[1]
    if(len(strings1)>=len(strings2)):
        print(strings1)
    elif (len(strings1)<len(strings2)):
        print(''.join([strings1,strings2[len(strings1):]]))
def LengthStrings(dict_val:dict):
    print("Do dai chuoi strings 1:",len((list(dict_val.values()))[0]),'\n',
    "Do dai chuoi strings 2:", len((list(dict_val.values()))[1]))
def CompareStrings(dict_val:dict):
    if list(dict_val.values())[0] == list(dict_val.values())[1]:
        print("Hai chuoi bang nhau")
    elif list(dict_val.values())[0] > list(dict_val.values())[1]:
        print("Chuoi thu nhat lon hon chuoi thu hai")
    else: print("chuoi thu nhat be hon chuoi thu hai")
def ComparePartStrings(dict_val:dict):
    n=int(input("Number of character wanna compare: "))
    strings1=list(dict_val.values())[0][:n]
    strings2=list(dict_val.values())[1][:n]
    if strings1 == strings2:
        print("Hai Strings bang nhau")
    elif strings1 > strings2:
        print("Strings1 lon hon Strings2 ")
    else: print("String 1 be hon Strings 2")
def FindOccurrencesStrings(dict_val:dict):
    import re
    index = [m.start() for m in re.finditer(list(dict_val.values())[0],list(dict_val.values())[1])]
    print("Các su xuat hien cua str1 trong str2 là:",index)
def main():
    import argparse
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter
    ,description='''
    Hello World: Viet chuong trinh python xu ly chuoi
    --------------------------------------------------
    Example:
    Main.py -str "nam" -str2 "tran" -func n
    trong đó: n là chức năng của các func, ví dụ: 1 - cộng chuỗi: string1 + string2.
    Usage:
    func:
    -1: Cong chuoi
    -2: Sao chep chuoi
    -3: Tinh do dai chuoi
    -4: So sanh chuoi
    -5: So sanh mot phan cua chuoi (n ky tu dau)
    -6: Tim vi tri xuat hien tu trong chuoi
    '''
    ,usage='''
    main.py [-h] for help,
    ''',epilog="Cam on ban da lang nghe"
    ,exit_on_error=False)
    #parser.add_argument('intergers', metavar='N', type=int, nargs='+', help='an tinterger for the accumulator of %(prog)s program')
    #parser.add_argument('--sum',dest='accumulate',action='store_const', const=sum, default=max,help='sum thee  intergers (default: find the max)')
    #parser.add_argument('bar', nargs='?', help='bar help')
    #parser.add_argument('--foo',nargs='?', help='FOO HELP  ')
    parser.add_argument('-str1',help="Nhap chuoi thu nhat", metavar="TRANVAN", required=True)
    parser.add_argument('-str2',help="Nhap chuoi thu hai", metavar="NAM",required=True)
    parser.add_argument('-func',metavar="{1 2 3 4 5 6}",help="Read from usage for document",required=True)
    #parser.add_argument('-func',choices=('1 2 3 4 5 6 1 -1 -2 -3 -4 -5 -6').split(), help="Read from usage for document",required=True)
    try:
        args=parser.parse_args()
    except :
        print("OOps, Try Again")
        parser.print_help()
        exit()
    myDict={
        "str1": args.str1,
        "str2":args.str2,
    }
    if abs(int(args.func))==1:
        AddStringsF(myDict)
    elif abs(int(args.func))==2:
        CopyStringF(myDict)
    elif abs(int(args.func))==3:
        LengthStrings(myDict)
    elif abs(int(args.func))==4:
        CompareStrings(myDict)
    elif abs(int(args.func))==5:
        ComparePartStrings(myDict)
    elif abs(int(args.func))==6:
        FindOccurrencesStrings(myDict)
    else: parser.print_help()
if __name__ == "__main__":
        main()