#!/usr/bin/python
import os,sys

def count(dir_):
    try:
        nfiles=int(os.popen("find '"+dir_+"' -type f | wc -l").read().strip())
        ndirs=int(os.popen("find '"+dir_+"' -type d | wc -l").read().strip())-1
        ndirs=0 if ndirs<1 else ndirs
        print(dir_, '-',nfiles+ndirs,'(f:'+str(nfiles)+' d:'+str(ndirs)+')')
    except Exception as e:
        print(e)
def main():
    #dirs=[os.environ['PWD'].split('/')[-1]] #get the name of '.'
    if len(sys.argv)>1:
        dirs=sys.argv[1:]
    else:
        dirs=list(filter(None,os.popen('find -maxdepth 1 -type d').read().split('\n')))
        if len(dirs)<2:
            dirs=[os.environ['PWD']]
    for d in dirs:
        count(d)
main()
