#!/bin/zsh
cnfdir="config_files"
c1="\033[0;32m"
c2="\033[0;34m"
rc="\033[0;31m"
nc="\033[0m"
bold="\033[1m"
url="ssh://gk1000@198.199.121.120:17/home/gk1000"
repos=("agriaid" "agtrade" "fsort" "gk1000.github.io" "learn" "resources" "sumaagrotech")

for ((i=1;i<${#repos};i++)) do
    echo $c1"git $url/$c2$bold$repos[$i].git$nc$c1 --recursive$nc"
    git clone "$url/$repos[$i].git" --recursive
    done