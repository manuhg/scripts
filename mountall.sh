modprobe nbd
i=0
for  vf in $(ls *.vdi)
do
echo =================================================================================================================
echo $vf
((i+=1))
j=$i
qemu-nbd -c /dev/nbd$i $vf 
mkdir  /media/gk1000/$vf
while true; do
     if [ -L /dev/mapper/cryptnbd$i ]; then
        ((i+=1))
     else
          if [ "$vf" == "tails2.vdi" ]; then
            cryptsetup  luksOpen /dev/nbd"$j"p2 cryptnbd$i
            mount /dev/mapper/cryptnbd$i /media/gk1000/$vf
            break
          fi
          cryptsetup  luksOpen /dev/nbd$j cryptnbd$i
          if [ -L /dev/mapper/cryptnbd$i ]; then
            mount /dev/mapper/cryptnbd$i /media/gk1000/$vf
          else
            echo mounting non LUKS device nbd$j to /media/gk1000/$vf
            mount /dev/nbd$j /media/gk1000/$vf
          fi
          break
     fi
done
done
./kmount.sh
