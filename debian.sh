#update repositories
apt update && apt upgrade -y

#firmware & drivers
apt install firmware-sof-signed firmware-realtek intel-microcode printer-driver-all printer-driver-cups-pdf -y

#desktop environment
apt install gnome-core file-roller cheese simple-scan gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks gnome-photos -y

#utilities
apt install curl tlp build-essential apt-transport-https python3-pip mlocate unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi -y

#fonts
apt install ttf-mscorefonts-installer ttf-ubuntu-font-family fonts-crosextra-carlito fonts-crosextra-caladea -y

#applications
apt install vlc vim htop neofetch timeshift gimp transmission-gtk libreoffice libreoffice-gnome libreoffice-style-breeze -y

#network
apt install net-tools avahi-daemon -y
systemctl enable avahi-daemon
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#virt manager
apt install virt-manager -y
adduser fabri libvirt
virsh net-autostart default

#firewall
apt install firewalld firewall-config -y
systemctl enable firewalld
firewall-cmd --set-default-zone=home

#printing and scanning
apt install cups sane -y
systemctl enable cups
usermod -a -G lpadmin fabri
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#cleanup extensions
rm -rf /usr/share/gnome-shell/extensions/*

#gnome extensions
apt install gnome-shell-extension-dash-to-panel -y

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
apt install /home/fabri/Downloads/google-chrome-stable_current_amd64.deb -y
rm /home/fabri/Downloads/*.deb

#vs code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt update
apt install code

#cleanup packages
apt autoremove -y

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

#swappiness
tee -a /etc/sysctl.conf  << END
vm.swappiness=10
END

#various
systemctl disable bluetooth
tlp start


