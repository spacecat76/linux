#install the KDE desktop environment
apt install kde-plasma-desktop snapd libreoffice libreoffice-kde5 vlc sane cups htop curl vim kamoso simple-scan tlp net-tools chromium ufw neofetch printer-driver-all firmware-sof papirus-icon-theme okular galculator transmission-qt ark kate kde-spectacle packagekit-qt5 print-manager ksystemlog timeshift kolourpaint ttf-mscorefonts-installer -y

shotwell gnome-keyring 

#remove uneeded applications
apt remove konqueror termit kdeconnect kwrite -y

#cleanup
apt autoremove -y
 
#install snap
snap install --classic code
snap install firefox

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
