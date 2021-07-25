#!/bin/bash

#set time
timedatectl set-ntp true
timedatectl set-timezone CET

#set locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
localectl set-locale LANGUAGE=en_US:en LC_TIME=it_IT.UTF-8 LC_MONETARY=it_IT.UTF-8 LC_MEASUREMENT=it_IT.UTF-8 LC_NUMERIC=it_IT.UTF-8 LC_PAPER=it_IT.UTF-8 LANG=en_US.UTF-8

#install applications
apt install xorg i3 lightdm network-manager simple-scan mpv galculator redshift slick-greeter timeshift ttf-mscorefonts-installer shotwell xfce4-screenshooter xfce4-terminal mousepad thunar-archive-plugin thunar-media-tags-plugin htop curl vim cheese transmission printer-driver-all libreoffice tlp libreoffice-gtk3 nitrogen libdbus-glib-1-2 xbacklight fonts-font-awesome picom lxappearance gnome-themes-extra papirus-icon-theme rofi net-tools xfce4-power-manager apt-transport-https firmware-linux pavucontrol i3blocks chromium volumeicon-alsa -y

#install firefox
wget https://ftp.mozilla.org/pub/firefox/releases/90.0/linux-x86_64/en-US/firefox-90.0.tar.bz2
mkdir /home/fabri/Applications
tar xjf firefox-*.tar.bz2 --directory /home/fabri/Applications
ln -s /home/fabri/Applications/firefox/firefox /usr/bin/firefox
rm firefox-*.tar.bz2

#set aliases
tee -a /home/fabri/.bash_aliases  << END
alias conf="nano ~/.config/i3/config"
alias ls="ls -lha --color"
END

#i3
mkdir -p /home/fabri/.config/i3
cp /home/fabri/Downloads/linux/etc/i3/config /home/fabri/.config/i3
cp /home/fabri/Downloads/linux/etc/i3/i3blocks.conf /home/fabri/.config/i3

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

#xbacklight
tee -a /etc/X11/xorg.conf  << END
Section "Device"
Identifier "Card0"
Driver "intel"
Option "Backlight" "intel_backlight"
EndSection
END

#redshift
tee -a /home/fabri/.config/redshift.conf  << END
[redshift]
location-provider=manual
dawn-time=09:00
dusk-time=20:00
END

#lightdm
cp /home/fabri/Downloads/linux/etc/img/ocean.jpg /usr/share/wallpapers
tee -a /etc/lightdm/slick-greeter.conf  << END
[Greeter]
draw-grid=false
background=/usr/share/wallpapers/ocean.jpg
END

#pulseaudio workaround
echo "options snd-hda-intel dmic_detect=0" | tee -a /etc/modprobe.d/alsa-base.conf

#bluetooth
systemctl disable bluetooth

#tlp
tlp start

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
usermod -G lpadmin -a fabri
systemctl enable cups --now

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
