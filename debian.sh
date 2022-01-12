#update repositories
apt update && apt upgrade -y

#desktop environment
apt install gnome-core file-roller gedit-plugin-terminal cheese gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks geary -y

#cleanup extensions
rm -rf /usr/share/gnome-shell/extensions/*

#gnome extensions
apt install gnome-shell-extension-dash-to-panel -y

#firmware
apt install firmware-sof-signed firmware-realtek intel-microcode -y

#utilities
apt install papirus-icon-theme net-tools curl tlp build-essential apt-transport-https python3-pip mlocate ffmpeg unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi -y

#fonts
apt install ttf-mscorefonts-installer ttf-ubuntu-font-family fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode -y

#applications
apt install vim htop neofetch timeshift transmission-gtk vlc shotwell gimp -y

#network
apt install avahi-daemon ufw -y
systemctl enable avahi-daemon
systemctl enable ufw
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
ufw allow mdns
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#virt manager
apt install virt-manager -y
adduser fabri libvirt
virsh net-autostart default

#printing and scanning
apt install sane cups printer-driver-all printer-driver-cups-pdf simple-scan -y
systemctl enable cups
usermod -a -G lpadmin fabri
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri
apt install /home/fabri/google-chrome-stable_current_amd64.deb -y
rm -f /home/fabri/google-chrome-stable_current_amd64.deb

#vs code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt update
apt install code -y

#purge components
apt purge bluez avahi-autoipd -y

#cleanup packages
apt autoremove -y

#flatpak
apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark com.system76.Popsicle io.gitlab.librewolf-community org.libreoffice.LibreOffice -y

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

#various
tlp start
