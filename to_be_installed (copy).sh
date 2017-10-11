
sudo bash
yes|rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
yes|dnf install git geoip golang mercurial VirtualBox filezilla glibc-static vlc nasm gcc php  glibc-devel.x86_64  java gcc-c++ geany gnome_tweak_tool glibc-devel.i686  libgcc.i686 java-1.7.0-openjdk linux-headers-$(uname -r)
#xampp android ide(s) netbeans
#rm -f winetricks
yes|wget http://winetricks.org/winetricks
sudo cp winetricks /usr/bin
sudo chmod +x /usr/bin/winetricks
go get github.com/rakyll/drive
winetricks atmlib gdiplus msxml3 msxml6 vcrun2005 vcrun2005sp1 vcrun2008 ie6 fontsmooth-rgb gecko
su -c "curl https://satya164.github.io/fedy/fedy-installer -o fedy-installer && chmod +x fedy-installer && ./fedy-installer"
yes|git clone https://github.com/LionSec/katoolin.git  && cp katoolin/katoolin.py /usr/bin/katoolin
 chmod +x  /usr/bin/katoolin
git clone https://git.fedorahosted.org/git/security-spin.git
drive init
