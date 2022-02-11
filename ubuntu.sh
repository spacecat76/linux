#install applications
apt install geary ubuntu-restricted-extras timeshift neofetch tlp curl wget htop shotwell net-tools apt-transport-https make python3-pip mlocate gimp vim gnome-tweaks cheese transmission papirus-icons-theme -y

#install fonts
apt install ttf-mscorefonts-installer fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode -y

#snaps
snap install code --classic
snap install libreoffice

#gnome extensions
apt purge gnome-shell-extension-appindicator gnome-shell-extension-desktop-icons-ng gnome-shell-extension-ubuntu-dock -yes
#apt install gnome-shell-extension-dashtodock -y

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
dpkg -i /home/fabri/Downloads/google-chrome-stable_current_amd64.deb
rm /home/fabri/Downloads/*.deb

#firewall
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

# grub
sed -i 's/quiet/quiet loglevel=3/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
update-grub

# purge components
apt purge bluez -y
apt autoremove -y

# various
tlp start
