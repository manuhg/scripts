#!/usr/bin/python3
import os,re,sys,getpass
d={'c':'/dev/sdb4','Hegde':'/dev/sdb5','Manu':'/dev/sdb6','Downloads':'/dev/sdb7','fl_linux':'/dev/sda6'}
lst=[]
if getpass.getuser()!='root':
    print("You need to be root\nExiting...\n")
    sys.exit()
try:
    if len(sys.argv)<2:
        #ip=input("Enter disks by name:")
        #lst=ip.split(",")
        print("\nSytax: $python3 mountro -<options fe=fl&heg, a=all>")
        sys.exit()
    else:
        lst=sys.argv[1:]
    if sys.argv[1]=='-fed':
        lst=['fl_linux','Hegde']
    elif sys.argv[1]=='-a':
        last=list(d.keys())
except:
    print("Error occurred with argv input.\nTaking default options.\nMouting sda6(fll) and sdb5(heg)")
    lst=['fl_linux','Hegde']

for i in lst:
    for pn,pd in d.items():
        dds='/media/gk1000/'+pn
        if re.search(i,pn,re.I) or re.search(i,pd,re.I):
            try:
                print("os.mkdir('%s')"%(dds))
                os.mkdir(dds)
            except FileExistsError:
                print("It seems that",dds,"already exists")
            try:
                print("os.system('mount %s %s')"%(pd,dds))
                os.system("mount -r "+pd+" "+dds)
            except :
                print("Error mounting %s(%s)"%(pn,pd))
