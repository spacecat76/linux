#update repositories
apt update

#install common apps
apt install sane cups avahi-daemon printer-driver-all printer-driver-cups-pdf htop curl vim tlp net-tools firewalld firewall-config neofetch timeshift ttf-mscorefonts-installer ttf-ubuntu-font-family firmware-sof-signed apt-transport-https firmware-realtek intel-microcode build-essential flatpak python3-pip fonts-crosextra-carlito fonts-crosextra-caladea mlocate unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi simple-scan vlc -y

#add user to group
usermod -a -G lpadmin fabri

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#tlp
tlp start

#locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

#grub
sed -i 's/quiet//g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
update-grub

#iwlwifi
tee -a /etc/modprobe.d/iwlwifi.conf  << END
options iwlwifi enable_ini=N
END

#services
systemctl disable bluetooth
systemctl enable cups
systemctl enable firewalld
systemctl enable avahi-daemon

#firewall
firewall-cmd --set-default-zone=home

#swappiness
tee -a /etc/sysctl.conf  << END
vm.swappiness=10
END

#install gnome
apt install gnome-core file-roller gnome-software-plugin-flatpak gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks gnome-photos -y

#remove uneeded gnome applications
apt remove --purge malcontent termit gnome-contacts xterm firefox-esr totem -y

#cleanup extensions
rm -rf /usr/share/gnome-shell/extensions/*

#dashtopanel
apt install gnome-shell-extension-dash-to-panel -y

#network manager
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark org.mozilla.firefox org.libreoffice.LibreOffice org.gnome.Boxes org.gnome.Builder org.gimp.GIMP org.gnome.Cheese com.transmissionbt.Transmission com.system76.Popsicle io.gitlab.librewolf-community -y

#chrome
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
#apt install /home/fabri/Downloads/google-chrome-stable_current_amd64.deb -y
#rm /home/fabri/Downloads/*.deb

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

#set x11 KB language (GDM)
localectl set-x11-keymap it

#cleanup packages
apt autoremove -y

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
