#!/bin/bash

#set time
timedatectl set-ntp true
timedatectl set-timezone CET

#set locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
localectl set-locale LANGUAGE=en_US:en LC_TIME=it_IT.UTF-8 LC_MONETARY=it_IT.UTF-8 LC_MEASUREMENT=it_IT.UTF-8 LC_NUMERIC=it_IT.UTF-8 LC_PAPER=it_IT.UTF-8 LANG=en_US.UTF-8

#install applications
apt install xorg kde-plasma-desktop simple-scan vlc galculator timeshift ttf-mscorefonts-installer shotwell htop curl vim cheese transmission printer-driver-all libreoffice tlp libdbus-glib-1-2 net-tools apt-transport-https firmware-linux chromium ark kate plasma-nm kde-spectacle libreoffice-gtk3 okular -y

#install firefox
wget https://ftp.mozilla.org/pub/firefox/releases/90.0/linux-x86_64/en-US/firefox-90.0.tar.bz2
mkdir /home/fabri/Applications
tar xjf firefox-*.tar.bz2 --directory /home/fabri/Applications
rm firefox-*.tar.bz2

#remove unwanted
sudo apt remove kdeconnect konqueror kwalletmanager kwrite termit -y

#set aliases
tee -a /home/fabri/.bash_aliases  << END
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

#autoremove
sudo apt autoremove -y
