# update repositories
apt update && apt upgrade -y

# firmware
apt install firmware-linux firmware-sof-signed firmware-realtek -y

# desktop environment
apt install gnome-core gnome-shell-extension-dash-to-panel gnome-weather gnome-calendar gnome-clocks gnome-tweaks file-roller seahorse transmission-gtk shotwell cheese -y

# apps & utilities
apt install timeshift vim htop neofetch unrar net-tools curl apt-file plymouth-themes -y

# multimedia
apt install vlc ffmpeg ffmpegfs libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly -y

# fonts & icons
apt install yaru-theme-gnome-shell yaru-theme-icon ttf-mscorefonts-installer fonts-ubuntu fonts-crosextra-carlito fonts-crosextra-caladea -y

# snaps
#apt install snapd -y
#snap install core gnome-boxes gimp pinta onlyoffice-desktopeditors
#snap install code --classic

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
dpkg -i /home/fabri/Downloads/google-chrome-stable_current_amd64.deb
rm /home/fabri/Downloads/*.deb

# network
apt install avahi-daemon firewalld firewall-config -y
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf
cp /home/fabri/Git/linux/etc/ffw.xml /usr/lib/firewalld/zones
firewall-cmd --reload
firewall-cmd --set-default-zone ffw

# printing and scanning
apt install sane cups printer-driver-all printer-driver-cups-pdf simple-scan -y
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
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END

# enable services
systemctl enable cups avahi-daemon firewalld
