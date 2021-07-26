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
pacman -S --needed xorg i3 lightdm lightdm-gtk-greeter network-manager redshift nano firefox xfce4-screenshooter xfce4-terminal mousepad thunar-archive-plugin thunar-media-tags-plugin sane cups nss-mdns vlc galculator shotwell htop curl vim cheese transmission-gtk simple-scan libreoffice tlp net-tools linux-firmware chromium nitrogen base-devel pipewire pipewire-alsa ufw picom lxappearance gnome-themes-extra papirus-icon-theme rofi net-tools xfce4-power-manager fuse gutenprint neofetch rust wget virtualbox gnome-keyring linux-headers volumeicon --noconfirm

#set aliases
tee -a /home/fabri/.bash_aliases  << END
alias conf="nano ~/.config/i3/config"
alias ls="ls -lha --color"
END

#i3
mkdir -p /home/fabri/.config/i3
cp /home/fabri/Documents/git/linux/etc/i3/config /home/fabri/.config/i3
cp /home/fabri/Documents/git/linux/etc/i3/i3blocks.conf /home/fabri/.config/i3

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

#redshift
tee -a /home/fabri/.config/redshift.conf  << END
[redshift]
location-provider=manual
dawn-time=09:00
dusk-time=20:00
END

#pulseaudio workaround
echo "options snd-hda-intel dmic_detect=0" | tee -a /etc/modprobe.d/alsa-base.conf

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.c

#tlp
tlp start

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

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
