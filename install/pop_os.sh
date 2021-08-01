#!/bin/bash

#install applications
apt install ubuntu-restricted-extras code timeshift neofetch virtualbox tlp ufw curl wget htop transmission cheese google-chrome-stable -y

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
