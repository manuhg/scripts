#!/bin/zsh

for dir in `find . -maxdepth 1 ! -path . -type d`
do
    echo "==============================================================================="
    dir=`basename $dir`
    echo $dir
 #   git --work-tree=$dir --git-dir=$dir/.git status
 #   git --work-tree=$dir --git-dir=$dir/.git remote remove origin
 #   git --work-tree=$dir --git-dir=$dir/.git remote add cloud "ssh://gk1000@manuhegde.in:17/home/gk1000/git/"$dir".git"
 #   git --work-tree=$dir --git-dir=$dir/.git remote add github "git@github.com:manuhg/"$dir".git"
 #   git --work-tree=$dir --git-dir=$dir/.git remote -v
    git --work-tree=$dir --git-dir=$dir/.git push --set-upstream cloud master
    git --work-tree=$dir --git-dir=$dir/.git pushall
    echo "==============================================================================="
done
