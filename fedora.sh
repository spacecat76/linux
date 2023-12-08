# dnf
tee -a /etc/dnf/dnf.conf << END
max_parallel_downloads=10
fastestmirror=True
END

# update
dnf update -y

# remove extensions and programs
dnf remove gnome-shell-extension-* -y

# rpm fusion
dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y

dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# media codecs
dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
dnf install lame\* --exclude=lame-devel -y
dnf group upgrade --with-optional Multimedia -y
dnf install ffmpeg-devel -y

# apps
dnf install vlc ffmpegthumbnailer google-chrome-stable gimp neofetch htop shotwell vim gnome-tweaks transmission gnome-extensions-app unrar gnome-shell-extension-dash-to-panel -y

# themes, fonts & icons
dnf install yaru-icon-theme papirus-icon-theme cabextract xorg-x11-font-utils -y
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf update -y
dnf install code -y

# firewall
dnf install firewall-config -y
cp /home/fabri/Git/linux/etc/ffw.xml /usr/lib/firewalld/zones
firewall-cmd --reload
firewall-cmd --set-default-zone ffw

# printing and scanning
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

# fastgate
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END
