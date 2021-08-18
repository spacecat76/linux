#enable non-free
sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list

#install common app
apt install flatpak libreoffice vlc sane cups htop curl vim simple-scan tlp net-tools chromium ufw neofetch printer-driver-all firmware-sof papirus-icon-theme timeshift ttf-mscorefonts-installer shotwell -y

#flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install firefox

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