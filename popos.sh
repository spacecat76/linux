# applications
apt install neofetch htop shotwell apt-transport-https code transmission cheese gimp vim gnome-tweaks libreoffice-style-breeze unrar -y

# multimedia
apt install vlc ffmpeg ubuntu-restricted-extras -y

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
apt install printer-driver-cups-pdf -y
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

# varie
systemctl disable bluetooth
apt autoremove -y