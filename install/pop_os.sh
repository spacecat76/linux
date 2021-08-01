#!/bin/bash

#install applications
apt install ubuntu-restriced-extras code timeshift neofetch virtualbox tlp ufw curl wget htop transmission cheese chromium

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
