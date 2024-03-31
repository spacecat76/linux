# refresh mirrors
pacman -Syyu

# gnome
pacman -S --needed gnome gnome-tweaks file-roller seahorse shotwell transmission-gtk gnome-themes-extra sassc --noconfirm

# gdm
systemctl enable gdm

# remove components
pacman -Rd --nodeps epiphany --noconfirm

# applications
pacman -S --needed firefox chromium vim nano vlc gimp htop neofetch timeshift podman distrobox starship --noconfirm
systemctl enable cronie 

# utilities
pacman -S --needed fwupd fuse-overlayfs speech-dispatcher curl neofetch rust wget bash-completion sof-firmware appstream mlocate unrar unzip p7zip fuse2 ffmpeg ffmpegthumbs gst-libav gst-plugins-ugly --noconfirm

# flatpak
pacman -S --needed flatpak --noconfirm
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --system flathub org.onlyoffice.desktopeditors -y

# fonts & icons
pacman -S --needed papirus-icon-theme ttf-ubuntu-font-family ttf-opensans ttf-carlito ttf-caladea ttf-liberation ttf-inconsolata ttf-dejavu noto-fonts adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts nerd-fonts --noconfirm

# network
pacman -S --needed nss-mdns inetutils net-tools avahi --noconfirm
systemctl enable avahi-daemon

# virt manager
pacman -S --needed qemu virt-manager dnsmasq --noconfirm
systemctl enable libvirtd.socket
usermod -a -G libvirt fabri
sed -i 's/#user = "libvirt-qemu"/user = "fabri"/g' /etc/libvirt/qemu.conf
sed -i 's/#group = "libvirt-qemu"/group = "libvirt"/g' /etc/libvirt/qemu.conf

# firewall
pacman -S --needed firewalld --noconfirm
nmcli connection modify FASTWEB connection.zone home
systemctl enable firewalld.service

# printing and scanning
pacman -S --needed sane cups cups-pdf gutenprint --noconfirm
systemctl enable cups
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf
echo "Out /home/${USER}/Documents" | tee -a /etc/cups/cups-pdf.conf

# fastgate
pacman -S --needed cifs-utils samba smbclient --noconfirm
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END
