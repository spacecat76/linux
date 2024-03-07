#kde
pacman -S --needed plasma plasma-wayland-session plasma-wayland-protocols sddm ark dolphin konsole okular kalk kate spectacle packagekit-qt5 packagekit-qt6 kdialog print-manager system-config-printer ksystemlog partitionmanager kamoso gwenview --noconfirm

#remove components
pacman -Rd --nodeps plasma-browser-integration --noconfirm

#sddm
systemctl enable sddm

#utilities
pacman -S --needed papirus-icon-theme curl neofetch rust wget linux-headers bash-completion sof-firmware appstream mlocate unrar unzip p7zip fuse2 ffmpeg pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse --noconfirm

#fonts
pacman -S --needed ttf-ubuntu-font-family ttf-opensans ttf-carlito ttf-caladea ttf-liberation ttf-inconsolata ttf-fira-code ttf-fira-mono ttf-fira-sans --noconfirm

#applications
pacman -S --needed firefox vim nano vlc gimp transmission-qt htop neofetch --noconfirm

#network
pacman -S --needed network-manager-applet nss-mdns inetutils net-tools avahi --noconfirm
systemctl enable avahi-daemon
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

# virt manager
pacman -S --needed virt-manager --noconfirm
systemctl enable libvirtd.socket
usermod -a -G libvirt fabri
virsh net-autostart default
sed -i 's/#user = "libvirt-qemu"/user = "fabri"/g' /etc/libvirt/qemu.conf
sed -i 's/#group = "libvirt-qemu"/group = "libvirt"/g' /etc/libvirt/qemu.conf

# ditrobox
pacman -S --needed podman distrobox --noconfirm

# flatpak
pacman -S --needed flatpak --noconfirm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.onlyoffice.desktopeditors io.gitlab.librewolf-community -y

#firewall
pacman -S --needed ufw --noconfirm
ufw enable
ufw allow mdns

#printing and scanning
pacman -S --needed sane cups gutenprint simple-scan --noconfirm
systemctl enable cups
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=2/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# fastgate
pacman -S --needed cifs-utils smbclient --noconfirm
cp /home/fabri/Git/linux/etc/smb.conf /etc/samba/smb.conf -rf
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin,x-systemd.after=network-online.target,user 0 0
END