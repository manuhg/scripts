#!/usr/bin/python
import os,re,sys

def parse(lst):
    lst=[ re.search('^[a-z0-9][^\s]{3,}',l,re.I) for l in lst]
    lst=list(filter(None,lst))
    lst=[l.group() for l in lst]
    return lst

def download(lst,dtype,c=''):
    if not dtype:
        return
    return [os.system('mkdir '+l.split('/')[-1]+' && kaggle '+dtype+' download '+c+l+' -p '+l.split('/')[-1]) for l in lst]

def print_lst(lst,lst_name=''):
    lst_name=lst_name.lower()
    lst_name=lst_name[0].upper()+lst_name[1:]
    print('================================================================================')
    print(lst_name+' : '+str(len(lst))+' \n================================================================================')
    [print(l) for l in lst]
    print('================================================================================')

def lst_vals(val_str):
    return list(filter(None,os.popen('kaggle '+val_str+' list').read().split('\n')))

def dw_competitions():
    competitions=parse(lst_vals('competitions'))
    print_lst(competitions,'competitions')
    download(competitions,'competitions','-c ')

def dw_datasets():
    datasets=parse(lst_vals('datasets'))
    print_lst(datasets,'datasets')
    download(datasets,'datasets')

def main():
    if len(sys.argv)<2:
        print("Speficy what to download: competitions | datasets | both")
    elif sys.argv[1] == 'datasets':
        dw_datasets()
    elif sys.argv[1] == 'competitions':
        dw_competitions()
    elif sys.argv[1] == 'both':
        dw_datasets()
        dw_competitions()
    else:
        print("Speficy what to download: competitions | datasets | both")

main()
