#!/usr/bin/python
import re,os,sys

def rename_in(dir_='.'):
    try:
        for f in os.listdir(dir_):
            new_name=re.sub('(.*)-(mod.*).mp4',r'\2-\1.mp4',f)
            print(f,'=>',new_name)
            f=dir_+'/'+f
            new_name=dir_+'/'+new_name
            os.system(str('mv "'+f+'" "'+new_name+'"'))
    except Exception as e:
        print(e)
def main():
    args=sys.argv[1:]
    if len(args)<1:
        args=os.listdir('.')
    for dir_ in args:
        rename_in(dir_)
main()
