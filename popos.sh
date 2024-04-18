# applications
apt install neofetch htop shotwell apt-transport-https code transmission cheese gimp vim gnome-tweaks libreoffice-style-breeze google-chrome-stable -y

# multimedia
apt install vlc ubuntu-restricted-extras -y

# firewall
apt install gufw -y
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
systemctl enable ufw --now
ufw enable
ufw allow mdns

# printing and scanning
apt install printer-driver-cups-pdf -y

# fastgate
apt install cifs-utils smbclient -y
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END

