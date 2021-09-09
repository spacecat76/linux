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
echo "Which DE would you like to install? (gnome, dwm, kde, xfce4, none or exit)"
read de
if [[ $de == "gnome" ]] || [[ $de == "kde" ]] || [[ $de == "dwm" ]] || [[ $de == "xfce4" ]] || [[ $de == "none" ]]; then
   jumpto install
elif [[ $de == "exit" ]]; then
   exit
else
   jumpto start
fi
install:
#add non free reps
sed -i 's+debian/ bullseye main+debian/ bullseye main contrib non-free+g' /etc/apt/sources.list
apt update

#install common app
apt install sane cups avahi-daemon printer-driver-all printer-driver-cups-pdf htop curl vim simple-scan tlp net-tools firewalld firewall-config neofetch papirus-icon-theme timeshift ttf-mscorefonts-installer firmware-sof-signed apt-transport-https firmware-realtek intel-microcode stacer make flatpak -y

#add user to group
sudo usermod -a -G lpadmin fabri

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#tlp
tlp start

#locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

#services
systemctl disable bluetooth
systemctl enable cups
systemctl enable firewalld
systemctl enable avahi-daemon

#firewall
firewall-cmd --set-default-zone=home

#flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.libreoffice.LibreOffice -y

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
apt install /home/fabri/Downloads/google-chrome-stable_current_amd64.deb -y
rm /home/fabri/Downloads/*.deb

#etcher
curl -1sLf \
   'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
   | sudo -E bash
apt update
apt install balena-etcher-electron -y

#vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt update
apt install code -y

#virtualbox
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bullseye contrib" | tee -a /etc/apt/sources.list
wget -qO- https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor > package1.oracle.gpg
wget -qO- https://www.virtualbox.org/download/oracle_vbox.asc | gpg -dearmor > package2.oracle.gpg
install -o root -g root -m 644 package1.oracle.gpg /etc/apt/trusted.gpg.d/
install -o root -g root -m 644 package2.oracle.gpg /etc/apt/trusted.gpg.d/
rm -f package*.oracle.gpg
apt update
apt install virtualbox-6.1 -y
apt remove zathura -y

#de install
if [[ $de == "gnome" ]]; then
   jumpto gnome
elif [[ $de == "kde" ]]; then
   jumpto kde
elif [[ $de == "dwm" ]]; then
   jumpto dwm
elif [[ $de == "xfce4" ]]; then
   jumpto xfce4
else
   jumpto final
fi

gnome:
#install gnome
apt install gnome-core cheese transmission-gtk file-roller gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks gnome-photos gnome-software-plugin-flatpak -y

#flatpak
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark -y

#remove uneeded gnome applications
apt remove malcontent termit -y

#delete gnome extensions
rm -rf /usr/share/gnome-shell/extensions/*

#install dash-to-panel
apt install gnome-shell-extension-dash-to-panel -y

#network manager
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

jumpto final

kde:
#install kde
apt install kde-plasma-desktop kamoso okular galculator transmission-qt ark kde-spectacle print-manager ksystemlog kolourpaint gnome-keyring plasma-nm shotwell pavucontrol vlc firefox-esr -y

#flatpak
flatpak override --user --env=GTK_THEME=Adwaita:dark org.libreoffice.LibreOffice

#remove uneeded kde applications
apt remove konqueror termit kdeconnect kwalletmanager -y

#kdewallet
tee -a /home/fabri/.config/kwalletrc  << END
Enabled=false
END

jumpto x11

xfce4:
apt install xfce4 slick-greeter xfce4-terminal xfce4-power-manager xfce4-taskmanager xfce4-screenshooter xfce4-clipman xfce4-whiskermenu-plugin xfce4-indicator-plugin xfce4-power-manager-plugins xfce4-clipman-plugin network-manager galculator transmission xarchiver thunar-archive-plugin mousepad shotwell mugshot redshift vlc firefox-esr -y

#flatpak
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark -y

#redshift
cp /home/fabri/Documents/git/linux/etc/dot/redshift.conf ~/.config

jumpto x11

dwm:
#install xfce4
apt install xorg picom dwm slick-greeter xfce4-terminal xfce4-power-manager xfce4-screenshooter network-manager galculator transmission xarchiver thunar thunar-archive-plugin mousepad shotwell redshift libreoffice-gtk vlc nitrogen lxappearance firefox-esr -y

#flatpak
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark -y

#dark theme
sed -i 's/0/1/g' .config/gtk-3.0/settings.ini

#redshift
cp /home/fabri/Documents/git/linux/etc/dot/redshift.conf ~/.config

jumpto x11

x11:
#touchpad X11
tee -a /etc/X11/xorg.conf.d/30-touchpad.conf  << END
Section "InputClass"
Identifier "touchpad"
Driver "libinput"
  MatchIsTouchpad "on"
  Option "Tapping" "on"
  Option "NaturalScrolling" "on"
  Option "ClickMethod" "clickfinger"
EndSection
END

#set x11 KB language (SDDM)
localectl set-x11-keymap it

jumpto final

final:
#cleanup
apt autoremove -y

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
