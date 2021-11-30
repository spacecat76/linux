#update repositories
apt update

#install DE and extras
apt install gnome-core sane cups curl tlp net-tools avahi-daemon printer-driver-all printer-driver-cups-pdf firewalld firewall-config firmware-sof-signed firmware-realtek intel-microcode build-essential apt-transport-https python3-pip mlocate unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi -y

#install gnome applications
apt install file-roller simple-scan gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks gnome-photos cheese -y

#install common applications
apt install vlc vim htop neofetch timeshift gimp transmission-gtk libreoffice libreoffice-gnome -y

#install fonts
apt install ttf-mscorefonts-installer ttf-ubuntu-font-family fonts-crosextra-carlito fonts-crosextra-caladea -y

#install flatpaks
#apt install flatpak gnome-software-plugin-flatpak -y
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark org.mozilla.firefox org.gnome.Boxes com.system76.Popsicle io.gitlab.librewolf-community -y

#remove uneeded gnome applications
#apt remove --purge malcontent termit gnome-contacts xterm firefox-esr totem -y

#cleanup extensions
#rm -rf /usr/share/gnome-shell/extensions/*

#dashtopanel
#apt install gnome-shell-extension-dash-to-panel -y

#chrome
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
#apt install /home/fabri/Downloads/google-chrome-stable_current_amd64.deb -y
#rm /home/fabri/Downloads/*.deb

#install vcode
#wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
#install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
#sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
#rm -f packages.microsoft.gpg
#apt update
#apt install code

#cleanup packages
apt autoremove -y

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

#network manager
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
