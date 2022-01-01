#kde
pacman -S --needed plasma plasma-wayland-session plasma-wayland-protocols sddm xarchiver thunar thunar-archive-plugin konsole okular galculator transmission-qt kate spectacle packagekit-qt5 print-manager system-config-printer ksystemlog partitionmanager kamoso gwenview kwallet-pam kwalletmanager --noconfirm

#kde unneeded apps
pacman -R plasma-browser-integration plasma-firewall --noconfirm

#utilities
pacman -S --needed htop curl tlp neofetch rust wget linux-lts-headers bash-completion sof-firmware appstream mlocate unrar unzip p7zip fuse ffmpeg --noconfirm

#fonts
pacman -S --needed ttf-ubuntu-font-family ttf-opensans ttf-carlito ttf-caladea ttf-liberation ttf-inconsolata ttf-fira-code ttf-fira-mono ttf-fira-sans --noconfirm

#applications
pacman -S --needed firefox chromium virtualbox vim nano vlc libreoffice-fresh gimp simple-scan --noconfirm

#network
pacman -S --needed network-manager-applet nss-mdns inetutils net-tools avahi --noconfirm
systemctl enable avahi-daemon
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#firewall
pacman -S firewalld --noconfirm
systemctl enable firewalld
firewall-cmd --set-default-zone=home

#printing and scanning
pacman -S --needed sane cups gutenprint --noconfirm
systemctl enable cups
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#grub
sed -i 's/loglevel=3 //g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#set x11 KB language (login manager)
localectl set-x11-keymap it

#various
systemctl disable bluetooth
systemctl enable sddm
tlp start
