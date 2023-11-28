#kde
pacman -S --needed plasma plasma-wayland-session plasma-wayland-protocols sddm ark dolphin konsole okular galculator kate spectacle packagekit-qt5 print-manager system-config-printer ksystemlog partitionmanager kamoso gwenview --noconfirm

#remove components
pacman -Rd --nodeps plasma-browser-integration --noconfirm

#sddm
systemctl enable sddm

#utilities
pacman -S --needed papirus-icon-theme htop curl neofetch rust wget linux-lts-headers bash-completion sof-firmware appstream mlocate unrar unzip p7zip fuse ffmpeg pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack --noconfirm

#fonts
pacman -S --needed ttf-ubuntu-font-family ttf-opensans ttf-carlito ttf-caladea ttf-liberation ttf-inconsolata ttf-fira-code ttf-fira-mono ttf-fira-sans --noconfirm

#applications
pacman -S --needed firefox vim nano vlc gimp transmission-qt pinta libreoffice-still --noconfirm

#network
pacman -S --needed network-manager-applet nss-mdns inetutils net-tools avahi --noconfirm
systemctl enable avahi-daemon
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

# snaps
pacman -S --needed snapd --noconfirm
snap install core gnome-boxes
snap install code --classic

#firewall
pacman -S firewalld --noconfirm
cp /home/fabri/Git/linux/etc/ffw.xml /usr/lib/firewalld/zones
firewall-cmd --reload
firewall-cmd --set-default-zone ffw

#printing and scanning
pacman -S --needed sane cups gutenprint simple-scan --noconfirm
systemctl enable cups
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=2/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# fastgate
pacman -S cifs-utils smbclient --noconfirm
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END