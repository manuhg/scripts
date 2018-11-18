#!/bin/sh
while true
do
	echo " "
	echo "=============================================================="
	echo "Press Ctrl+c to quit"
	echo " "
	echo "Search: "
	read search_text
	echo "=============================================================="
	ls -R '/Volumes/FS 2/Images for website/Uploaded/Free_Download'  | grep -iE '\.(jpeg|jpg)'  | grep -i $search_text| sed -e 's/\.jpg//g;s/\.JPG//g;s/\.jpeg//g;'|sort|uniq|sort
done
