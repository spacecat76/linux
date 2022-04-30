# update repositories
apt update && apt full-upgrade -y

# firmware
apt install firmware-sof-signed firmware-realtek intel-microcode -y

# desktop environment
apt install adwaita-icon-theme at-spi2-core baobab caribou dconf-cli dconf-gsettings-backend eog evince evolution-data-server fonts-cantarell gdm3 gkbd-capplet glib-networking gnome-backgrounds gnome-bluetooth gnome-calculator gnome-characters gnome-contacts gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-online-accounts gnome-online-miners gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-software gnome-sushi gnome-system-monitor gnome-terminal gnome-text-editor gnome-themes-extra gnome-user-docs gnome-user-share gsettings-desktop-schemas gstreamer1.0-packagekit gstreamer1.0-plugins-base gstreamer1.0-plugins-good gvfs-backends gvfs-fuse libatk-adaptor libcanberra-pulse libglib2.0-bin libpam-gnome-keyring libproxy1-plugin-gsettings libproxy1-plugin-webkit librsvg2-common nautilus pipewire-pulse sound-theme-freedesktop system-config-printer-common system-config-printer-udev totem tracker xdg-desktop-portal-gnome yelp zenity libproxy1-plugin-networkmanager network-manager-gnome file-roller cheese gnome-tweaks gnome-weather gnome-calendar gnome-clocks geary transmission-gtk shotwell gnome-shell-extension-dash-to-panel -y

# apps & utilities
apt install gimp vim htop neofetch timeshift vlc papirus-icon-theme net-tools curl build-essential apt-transport-https python3-pip mlocate ffmpeg unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-ugly -y

# fonts
apt install ttf-mscorefonts-installer fonts-ubuntu fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode -y

# network
apt install avahi-daemon ufw -y
systemctl enable avahi-daemon
systemctl enable ufw --now
ufw enable
ufw allow mdns
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

# virt manager
apt install virt-manager -y
adduser fabri libvirt

# printing and scanning
apt install sane cups printer-driver-all printer-driver-cups-pdf simple-scan -y
systemctl enable cups
usermod -a -G lpadmin fabri
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

# google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri
apt install /home/fabri/google-chrome-stable_current_amd64.deb -y
rm -f /home/fabri/google-chrome-stable_current_amd64.deb

# vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt update && apt install code -y

# flatpak
apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.onlyoffice.desktopeditors com.system76.Popsicle io.gitlab.librewolf-community -y

# locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

# grub
sed -i 's/quiet/quiet loglevel=3/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
update-grub

## optional

# purge components
apt purge bluez avahi-autoipd -y
apt autoremove -y
