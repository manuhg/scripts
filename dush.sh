#!/usr/bin/zsh
if [ $# -eq 0 ]; then
   dir='.'
else
   dir=$1
fi
du -sh $dir/* | sort -hr
