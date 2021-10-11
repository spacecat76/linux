#!/bin/bash

#remove applications
apt remove geary -y

#install applications
apt install ttf-mscorefonts-installer timeshift neofetch tlp curl wget htop gnome-photos printer-driver-cups-pdf net-tools firewalld firewall-config apt-transport-https stacer make python3-pip fonts-crosextra-carlito fonts-crosextra-caladea mlocate code transmission cheese google-chrome-stable -y

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl enable cups
systemctl enable firewalld
systemctl enable avahi-daemon

#firewall
firewall-cmd --set-default-zone=home

#cleanup
apt autoremove -y

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
