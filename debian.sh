#update repositories
apt update && apt upgrade -y

#desktop environment
apt install gnome-core geary file-roller gedit-plugin-terminal cheese gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks shotwell -y

#cleanup extensions
rm -rf /usr/share/gnome-shell/extensions/*

#gnome extensions
apt install gnome-shell-extension-dash-to-panel -y

#firmware
apt install firmware-sof-signed firmware-realtek intel-microcode -y

#utilities
apt install net-tools curl tlp build-essential apt-transport-https python3-pip mlocate ffmpeg unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi -y

#fonts
apt install ttf-mscorefonts-installer ttf-ubuntu-font-family fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode -y

#applications
apt install vlc vim htop neofetch timeshift gimp transmission-gtk libreoffice libreoffice-style-breeze libreoffice-gnome -y

#network
apt install avahi-daemon -y
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
apt install sane cups printer-driver-all printer-driver-cups-pdf simple-scan -y
systemctl enable cups
usermod -a -G lpadmin fabri
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri
apt install /home/fabri/google-chrome-stable_current_amd64.deb -y
rm -f /home/fabri/google-chrome-stable_current_amd64.deb

#purge components
apt purge bluez avahi-autoipd totem malcontent gnome-contacts virt-viewer -y

#cleanup packages
apt autoremove -y

#flatpak
apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark com.system76.Popsicle -y

#locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

#disable pipewire
systemctl disable --global pipewire
rm -rf /home/fabri/.config/pulse

#grub
sed -i 's/quiet/quiet loglevel=3/g' /etc/default/grub
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
tlp start
