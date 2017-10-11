for d in $(ls /dev/mapper/cryptnbd*) 
do 
umount  $d
cryptsetup luksClose $(basename $d) 
done

for d in $(ls /dev/nbd*)
do
 umount $d
 qemu-nbd -d $d
done

for d in $(ls -d /media/gk1000/*.vdi)
do
  rmdir $d
done
