#!/bin/bash

#set time
timedatectl set-ntp true
timedatectl set-timezone CET

#set locale
sed -i 's/#it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
sed -i '$ d' /etc/locale.gen
locale-gen
localectl set-locale LANGUAGE=en_US:en LC_TIME=it_IT.UTF-8 LC_MONETARY=it_IT.UTF-8 LC_MEASUREMENT=it_IT.UTF-8 LC_NUMERIC=it_IT.UTF-8 LC_PAPER=it_IT.UTF-8 LANG=en_US.UTF-8 LC_COLLATE=it_IT.UTF-8

#install applications
pacman -S --needed gnome-shell gdm gnome-control-center gnome-terminal gnome-software gnome-software-packagekit-plugin file-roller gedit nautilus gnome-tweaks nano firefox sane cups nss-mdns htop curl vim cheese gnome-calculator gnome-photos gnome-music totem gnome-screenshot gnome-logs gnome-system-monitor evince transmission-gtk simple-scan libreoffice tlp net-tools linux-firmware chromium base-devel ufw fuse gutenprint neofetch rust wget virtualbox gnome-keyring linux-headers --noconfirm

#pulseaudio workaround
echo "options snd-hda-intel dmic_detect=0" | tee -a /etc/modprobe.d/alsa-base.conf

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
systemctl enable gdm
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