# install applications
apt install ubuntu-restricted-extras timeshift neofetch curl wget htop shotwell net-tools apt-transport-https make vim gnome-tweaks cheese transmission vlc gnome-shell-extension-manager fuse3 gimp ffmpegthumbnailer gnome-screenshot -y

# install fonts
apt install fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode -y

# snaps
snap install code --classic
snap install libreoffice

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
dpkg -i /home/fabri/Downloads/google-chrome-stable_current_amd64.deb
rm /home/fabri/Downloads/*.deb

# firewall
apt install gufw -y
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
systemctl enable ufw --now
ufw enable
ufw allow mdns

# virt manager
apt install virt-manager -y
virsh net-autostart default

# printing and scanning
apt install sane printer-driver-all printer-driver-cups-pdf simple-scan -y
usermod -a -G lpadmin fabri
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

# fastgate
apt install cifs-utils smbclient -y
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END

# grub
sed -i 's/quiet/quiet loglevel=3/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
update-grub

# disable services
systemctl disable pipewire bluetooth
rm -rf /home/fabri/.config/pulse
