#!/bin/bash

#install applications
pacman -S --needed plasma plasma-wayland-session sddm dolphin firefox konsole sane cups nss-mdns vlc okular galculator shotwell htop curl vim cheese transmission-qt simple-scan libreoffice tlp net-tools chromium ark kate spectacle packagekit-qt5 pipewire pipewire-alsa ufw print-manager system-config-printer fuse gutenprint neofetch rust wget ksystemlog virtualbox gnome-keyring linux-headers --noconfirm

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf

#set aliases
tee -a /home/fabri/.bashrc  << END
alias ls="ls -lha --color"
END

#services
systemctl disable bluetooth
systemctl disable iptables.service
systemctl enable sddm
systemctl enable avahi-daemon.service
systemctl enable cups

#ufw
ufw enable
ufw allow 5353/udp
systemctl enable ufw

#tlp
tlp start

#setting permission to home folder
chown -R fabri:fabri /home/fabri/