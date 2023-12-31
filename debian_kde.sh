# update repositories
apt update && apt upgrade -y

# firmware
apt install firmware-linux firmware-sof-signed firmware-realtek -y

# desktop environment
apt install kde-plasma-desktop ark galculator kde-spectacle okular -y

#remove components
apt purge plasma-browser-integration konqueror zutty -y

# apps & utilities
apt install firefox-esr gimp shotwell tlp pkexec timeshift vim htop neofetch unrar net-tools curl apt-file plymouth-themes transmission-qt -y

# multimedia
apt install vlc ffmpeg ffmpegfs libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly -y

# fonts & icons
apt install ttf-mscorefonts-installer fonts-ubuntu fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode papirus-icon-theme -y

# chrome
apt install libu2f-udev -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
dpkg -i --force-all /home/fabri/Downloads/google-chrome-stable_current_amd64.deb
rm /home/fabri/Downloads/*.deb

# code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt update && apt install code -y

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
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin,noauto,x-systemd.automount,user 0 0
END

# enable services
systemctl enable cups avahi-daemon ufw

# various
apt autoremove -y
tlp start