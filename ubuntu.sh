#!/bin/bash

#remove applications
sudo apt remove gnome-shell-extension-appindicator gnome-shell-extension-ubuntu-dock thunderbird shotwell aisleriot deja-dup gnome-mahjongg gnome-mines gnome-sudoku remmina -y

#install applications
apt install ubuntu-restricted-extras gnome-shell-extension-dash-to-panel timeshift neofetch tlp curl wget htop gnome-photos printer-driver-cups-pdf net-tools firewalld firewall-config apt-transport-https stacer make ython3-pip fonts-crosextra-carlito fonts-crosextra-caladea mlocate -y

#snaps
snap install code --classic

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
apt install /home/fabri/Downloads/google-chrome-stable_current_amd64.deb -y
rm /home/fabri/Downloads/*.deb

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl enable cups
systemctl enable firewalld
systemctl enable avahi-daemon

#cleanup
apt autoremove -y

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
