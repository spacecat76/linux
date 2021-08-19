#install common app
apt install libreoffice vlc sane cups printer-driver-cups-pdf htop curl vim simple-scan tlp net-tools pavucontrol ufw neofetch printer-driver-all papirus-icon-theme timeshift ttf-mscorefonts-installer shotwell firmware-sof-signed apt-transport-https plasma-nm -y

#add user to groups
sudo usermod -a -G lpadmin fabri

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#ufw
ufw enable

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl enable cups
systemctl enable ufw