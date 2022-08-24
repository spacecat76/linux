#install applications
apt install neofetch htop shotwell printer-driver-cups-pdf apt-transport-https code transmission cheese gimp vim ffmpeg gnome-tweaks libreoffice-style-breeze -y

#install fonts
apt install ttf-mscorefonts-installer ttf-ubuntu-font-family fonts-crosextra-carlito fonts-crosextra-caladea -y

#firewall
apt install gufw -y
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
systemctl enable ufw --now
ufw enable
ufw allow mdns

# virt manager
apt install virt-manager -y
virsh net-autostart default

#scanner
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

# purge components
apt purge bluez -y

#cleanup
apt autoremove -y