dirs=$@
#[ $# -lt 1 ] && dirs= ["."]
for dir in  $dirs
do
	cd $dir && echo "cd $dir"
	git fsck
	git repack -adf --window 1 --window-memory "40m"
done
