#gnome
pacman -S --needed baobab cheese eog evince file-roller gdm gedit gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-tweaks gnome-menus gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-software gnome-system-monitor gnome-terminal gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mutter nautilus rygel sushi tracker tracker-miners tracker3-miners xdg-user-dirs-gtk shotwell geary gedit-plugins gnome-software-packagekit-plugin --noconfirm

#remove components
pacman -Rd --nodeps pulseaudio-bluetooth bluez --noconfirm

#gdm
systemctl enable gdm

#utilities
pacman -S --needed papirus-icon-theme htop curl neofetch rust wget linux-headers bash-completion sof-firmware appstream mlocate unrar unzip p7zip fuse ffmpeg --noconfirm

#fonts
pacman -S --needed ttf-ubuntu-font-family ttf-opensans ttf-carlito ttf-caladea ttf-liberation ttf-inconsolata ttf-fira-code ttf-fira-mono ttf-fira-sans --noconfirm

#applications
pacman -S --needed firefox chromium vim nano vlc libreoffice-fresh gimp transmission-gtk --noconfirm

#network
pacman -S --needed network-manager-applet nss-mdns inetutils net-tools avahi --noconfirm
systemctl enable avahi-daemon
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#virt manager
pacman -S --needed virt-manager libvirt iptables-nft qemu dnsmasq --noconfirm
systemctl enable libvirtd
usermod -aG libvirt fabri

#firewall
pacman -S firewalld --noconfirm
systemctl enable ufw
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
ufw allow mdns

#printing and scanning
pacman -S --needed sane cups gutenprint simple-scan --noconfirm
systemctl enable cups
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#disable pipewire
systemctl disable --global pipewire
rm -rf /home/fabri/.config/pulse

#grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg