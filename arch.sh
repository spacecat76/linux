#!/bin/bash

#jumpto
function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
start=${1:-"start"}

jumpto $start

#de selection
start:
echo "Which DE would you like to install? (gnome, kde, none or exit)"
read de
if [[ $de == "gnome" ]] || [[ $de == "kde" ]] || [[ $de == "none" ]]; then
   jumpto install
elif [[ $de == "exit" ]]; then
   exit
else
   jumpto start
fi
install:

#install applications
pacman -S --needed firefox sane cups nss-mdns htop curl vim cheese vlc simple-scan libreoffice tlp net-tools chromium firewalld fuse gutenprint neofetch rust wget virtualbox linux-lts-headers ttf-ubuntu-font-family papirus-icon-theme bash-completion sof-firmware appstream gimp --noconfirm

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf

#firewall
firewall-cmd --set-default-zone=home

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl enable firewalld
systemctl enable avahi-daemon
systemctl enable cups

#de install
if [[ $de == "gnome" ]]; then
   jumpto gnome
elif [[ $de == "kde" ]]; then
   jumpto kde
else
   jumpto final
fi

gnome:
#install gnome applications
pacman -S --needed gnome-shell gdm gnome-control-center gnome-terminal gnome-software gnome-software-packagekit-plugin file-roller gedit nautilus gnome-tweaks gnome-calculator gnome-screenshot gnome-logs tracker gnome-system-monitor evince transmission-gtk gnome-weather gnome-photos builder --noconfirm

#enable gdm
systemctl enable gdm

kde:
#install kde applications
pacman -S --needed plasma plasma-wayland-session sddm dolphin konsole okular galculator transmission-qt ark kate spectacle packagekit-qt5 print-manager system-config-printer ksystemlog kdevelop shotwell --noconfirm

#enable sddm
systemctl enable sddm

final:
#set x11 KB language (login manager)
localectl set-x11-keymap it

#setting permission to home folder
chown -R fabri:fabri /home/fabri/

