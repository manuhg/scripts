find . -type f | perl -n -e 'chomp; system("mv", $_, lc($_))'
