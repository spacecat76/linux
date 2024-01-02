# update repositories
apt update && apt upgrade -y

# firmware
apt install firmware-linux firmware-sof-signed firmware-realtek -y

# desktop environment
apt install kde-plasma-desktop ark galculator kde-spectacle okular -y

# pipewire
apt install pipewire pipewire-alsa pipewire-jack pipewire-audio wireplumber pipewire-pulse -y

#remove components
apt purge plasma-browser-integration konqueror zutty -y

# apps & utilities
apt install shotwell tlp pkexec timeshift vim htop neofetch unrar net-tools curl apt-file plymouth-themes transmission-qt -y

# multimedia
apt install vlc ffmpeg ffmpegfs libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly -y

# fonts & icons
apt install ttf-mscorefonts-installer fonts-ubuntu fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode papirus-icon-theme -y

# snaps
apt install snapd -y
snap install core firefox gimp onlyoffice-desktopeditors
snap install code --classic

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -f ./google-chrome-stable_current_amd64.deb -y
rm -f google-chrome-stable_current_amd64.deb

# network
apt install avahi-daemon ufw plasma-firewall -y
ufw enable
ufw allow mdns
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

# virt manager
apt install virt-manager -y
adduser fabri libvirt
virsh net-autostart default

# printing and scanning
apt install sane cups printer-driver-all printer-driver-cups-pdf simple-scan print-manager -y
systemctl enable cups
usermod -a -G lpadmin fabri
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

# locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

# grub
sed -i 's/quiet/quiet loglevel=3 splash/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=2/g' /etc/default/grub
update-grub

# plymouth themes
plymouth-set-default-theme -R lines

# fastgate
apt install cifs-utils smbclient -y
cp /home/fabri/Git/linux/etc/smb.conf /etc/samba/smb.conf -rf

# enable services
systemctl enable cups avahi-daemon

# various
apt autoremove -y
tlp start
