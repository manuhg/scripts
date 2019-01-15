wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda

sudo apt-get install xfce4 xfce4-goodies
sudo apt-get install vlc firefox tightvncserver
#cat /dev/null > ~/.vnc/xstartup
vncserver
cat > ~/.vnc/xstartup << EOM
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOM
chmod +x ~/.vnc/xstartup

