git repack -adf --window 1 --window-memory "40m"
git fsck
git repack --window 2 --window-memory "50m"
