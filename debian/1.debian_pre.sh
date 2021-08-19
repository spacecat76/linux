#install common app
apt install libreoffice vlc sane cups htop curl vim simple-scan tlp net-tools pavucontrol ufw neofetch printer-driver-all papirus-icon-theme timeshift ttf-mscorefonts-installer shotwell firmware-sof-signed apt-transport-https -y

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