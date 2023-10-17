# install applications
apt install ubuntu-restricted-extras gnome-shell-extension-manager gnome-weather gnome-calendar gnome-clocks gnome-tweaks vlc ffmpegthumbnailer timeshift neofetch curl wget htop net-tools apt-transport-https vim cheese shotwell transmission -y

# fonts & icons
apt install fonts-crosextra-carlito fonts-crosextra-caladea -y

# snaps
snap install code --classic
snap install gnome-boxes gimp onlyoffice-desktopeditors pinta

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
dpkg -i /home/fabri/Downloads/google-chrome-stable_current_amd64.deb
rm /home/fabri/Downloads/*.deb

# firewall
apt install firewalld firewall-config -y
cp /home/fabri/Git/linux/etc/ffw.xml /usr/lib/firewalld/zones
firewall-cmd --reload
firewall-cmd --set-default-zone ffw
# apt install ufw -y
# sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
# systemctl enable ufw --now
# ufw enable
# ufw allow mdns

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
tee -a /etc/default/grub << END
GRUB_RECORDFAIL_TIMEOUT=5
END
update-grub
