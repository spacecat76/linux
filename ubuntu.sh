#!/bin/bash

#remove applications
apt remove gnome-shell-extension-appindicator gnome-shell-extension-ubuntu-dock -y

#install applications
apt install ubuntu-restricted-extras timeshift neofetch tlp curl wget htop gnome-photos printer-driver-cups-pdf net-tools firewalld firewall-config apt-transport-https make python3-pip fonts-crosextra-carlito fonts-crosextra-caladea mlocate gnome-boxes libreoffice -y

#snaps
snap install code --classic

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
dpkg -i /home/fabri/Downloads/google-chrome-stable_current_amd64.deb
rm /home/fabri/Downloads/*.deb

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl enable cups
systemctl enable firewalld

#firewall
firewall-cmd --set-default-zone=home

#cleanup
apt autoremove -y

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
