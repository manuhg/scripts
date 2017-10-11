modprobe nbd
echo =================================================================================================================
cd "/home/gk1000/VirtualBox VMs/kal"
vf="kal.vdi"
echo $vf
i=1
mkdir  /media/gk1000/$vf
while true; do
     if [ -L /dev/mapper/cryptnbd$i ]; then
        ((i+=1))
     else      
        echo mounting non LUKS device nbd$i to /media/gk1000/$vf
	((i+=1))
        qemu-nbd -c /dev/nbd$i $vf	
        mount /dev/nbd"$i"p1  /media/gk1000/$vf
        break
     fi
done
