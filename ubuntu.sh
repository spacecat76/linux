#remove extensions
apt remove gnome-shell-extension-appindicator gnome-shell-extension-ubuntu-dock -y

#install extension
apt install gnome-shell-extension-dash-to-panel -y

#install applications
apt install geary ubuntu-restricted-extras timeshift neofetch tlp curl wget htop gnome-photos printer-driver-cups-pdf net-tools apt-transport-https make python3-pip mlocate gimp vim gnome-tweaks cheese virtualbox -y

#install fonts
apt install ttf-mscorefonts-installer fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode -y

#snaps
snap install code --classic
snap install libreoffice

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
dpkg -i /home/fabri/Downloads/google-chrome-stable_current_amd64.deb
rm /home/fabri/Downloads/*.deb

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#firewall
apt install firewalld firewall-config -y
systemctl enable firewalld
firewall-cmd --set-default-zone=home

#services
systemctl disable bluetooth
tlp start

#cleanup
apt autoremove -y
