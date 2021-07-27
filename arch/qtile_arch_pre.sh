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
pacman -S --needed xorg qtile lightdm lightdm-gtk-greeter thunar nano firefox redshift networkmanager xfce4-screenshooter xfce4-terminal mousepad thunar-archive-plugin thunar-media-tags-plugin transmission-gtk nitrogen ttf-font-awesome picom lxappearance gnome-themes-extra papirus-icon-theme rofi net-tools xfce4-power-manager sane cups nss-mdns vlc evince galculator shotwell htop curl vim cheese simple-scan libreoffice tlp linux-firmware chromium base-devel pulseaudio pulseaudio-alsa ufw fuse gutenprint neofetch rust wget virtualbox gnome-keyring linux-headers --noconfirm

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

#touchpad
tee -a /etc/X11/xorg.conf.d/90-touchpad.conf  << END
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "True"
EndSection
END

#services
systemctl disable bluetooth
systemctl disable iptables.service
systemctl enable lightdm
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