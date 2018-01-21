#!/bin/zsh

c1="\033[0;32m"
c2="\033[0;34m"
rc="\033[0;31m"
nc="\033[0m"
bold="\033[1m"

if [ $# -eq 0 ]; then
    echo "Please enter the name of submodule to be removed"
else
    echo "Removing submodule $c1$bold$1$nc"
    git submodule deinit -f -- $1
    git rm --cached $1
    rm -rf .git/modules/$1
    git rm -f $1
    rm -rf $1
    cat .gitmodules| grep -vE \\b$1\\b 
    cat .gitmodules| grep -vE \\b$1\\b > .gitmadules
    cp .gitmodules .gitmodules.old
    mv .gitmadules .gitmodules
fi