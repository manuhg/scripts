#/bin/sh
ls | xargs -0 | sed -e 's/.\{2\}/\x&/g;' |xargs  echo -ne | grep .tar 
