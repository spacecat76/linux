#!/bin/bash

#install applications
pacman -S --needed plasma plasma-wayland-session sddm dolphin firefox konsole sane cups nss-mdns vlc okular galculator shotwell htop curl vim cheese transmission-qt simple-scan libreoffice tlp net-tools chromium ark kate spectacle packagekit-qt5 ufw print-manager system-config-printer fuse gutenprint neofetch rust wget ksystemlog gnome-keyring linux-lts-headers ttf-ubuntu-font-family papirus-icon-theme --noconfirm

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf

#ufw
ufw enable

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl disable iptables
systemctl enable gdm
systemctl enable avahi-daemon
systemctl enable cups
systemctl enable ufw

#setting permission to home folder
chown -R fabri:fabri /home/fabri/