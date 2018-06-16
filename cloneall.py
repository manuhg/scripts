#!/usr/bin/python
import os,sys
from github import Github
#can be obtained by
#pip install pygithub
#clone_options=['bare','recursive']
clone_cmd='git clone --recursive '
auto_clone_excludes=['dev.git','arch.git','scripts.git','pram.git']

def clone(repo_name,base_url='',exclude=[]):
    if repo_name not in exclude and os.system(clone_cmd+base_url+repo_name)==0: #+' 2>/dev/null'
        return repo_name

def clone_from_github(repo):
    if hasattr(repo,'ssh_url') and clone(repo.ssh_url,'',auto_clone_excludes):
        try:
            os.system('cd '+repo.name+' && git remote add cloud ssh://gk1000@198.199.121.120:17/home/gk1000/'+repo.name+'.git && cd ..')
        except Exception as e:
            print(e)
        return repo.name

def clone_from_cloud(repo):
    return clone(repo,'ssh://gk1000@198.199.121.120:17/home/gk1000/',auto_clone_excludes)

def print_res(reps_lst,rep_names):
    cloned=list(filter(None,reps_lst))
    if len(reps_lst) != len(rep_names): print ("Mismatch!")
    print("Found" ,len(rep_names),"repositories:\n",rep_names)
    print("Cloned",len(cloned),"repositories:\n",cloned)

def cloneall(repos,clone_func,rep_func):
    cloned=list(map(clone_func,repos))
    print_res(cloned,list(map(rep_func,repos)))

def github_clone_all():
    try:
        repos=Github('a014a3246227bd6c657766fcb45a98613ac87480').get_user().get_repos()
        cloneall(repos,clone_from_github,lambda r:r.name )
        print("Successfully cloned from github")
    except Exception as e:
        print(e)
        print("Could not clone from github")

def cloud_clone_all():
    try:
        repos=os.popen('ssh gk1000@198.199.121.120 -p 17 ls -l | grep -Eo "[a-zA-Z0-9_\-]+.git"').read().strip().split('\n')
        cloneall(repos,clone_from_cloud,lambda r:r)
        print("Successfully cloned from cloud")
    except Exception as e:
        print(e)
        print("Could not clone from cloud")

def main():
    if len(sys.argv) > 1:
        #print({"all":github_clone_all() or cloud_clone_all(),"github":github_clone_all(),"cloud":cloud_clone_all()}.get(sys.argv[1],"invalid parameter")) #bad idea!
        global clone_cmd
        clone_cmd+=' '.join(sys.argv[2:])+' '
        if sys.argv[1]=="all":
            github_clone_all()
            cloud_clone_all()
        elif sys.argv[1]=="github":
            github_clone_all()
        elif sys.argv[1]=="cloud":
            cloud_clone_all()
        else:
            print("invalid parameter")
main()
