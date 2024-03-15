# install applications
apt install ubuntu-restricted-extras gnome-shell-extension-manager gnome-weather gnome-calendar gnome-clocks gnome-tweaks vlc ffmpegthumbnailer timeshift neofetch curl wget htop net-tools apt-transport-https vim cheese shotwell transmission usb-creator-gtk -y

# fonts & icons
apt install papirus-icon-theme fonts-crosextra-carlito fonts-crosextra-caladea -y

# snaps
snap install gimp onlyoffice-desktopeditors
snap install code --classic

# virt manager
apt install virt-manager bridge-utils -y
adduser fabri libvirt
virsh net-autostart default
sed -i 's/#user = "libvirt-qemu"/user = "fabri"/g' /etc/libvirt/qemu.conf
sed -i 's/#group = "libvirt-qemu"/group = "libvirt"/g' /etc/libvirt/qemu.conf

# chrome
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#apt install -f ./google-chrome-stable_current_amd64.deb -y
#rm -f google-chrome-stable_current_amd64.deb

# firewall
ufw enable
ufw allow mdns

# printing and scanning
apt install sane printer-driver-all printer-driver-cups-pdf simple-scan -y
adduser fabri lpadmin
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

# fastgate
apt install cifs-utils smbclient -y
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END

# locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

# grub
sed -i 's/quiet/quiet loglevel=3/g' /etc/default/grub
tee -a /etc/default/grub << END
GRUB_RECORDFAIL_TIMEOUT=5
END
update-grub

# various
sed -i 's/#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=30s/g' /etc/systemd/system.conf
sed -i 's/#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=30s/g' /etc/systemd/user.conf