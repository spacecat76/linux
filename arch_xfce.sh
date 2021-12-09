#desktop environment
pacman -S xfce4 xfce4-dev-tools lighdm lightdm-gtk-greeter lightdm-slick-greeter xfce4-screenshooter xfce4-terminal xarchiver thunar-archive-plugin transmission-gtk xfce4-battery-plugin xfce4-datetime-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-whiskermenu-plugin gthumb galculator mousepad gparted redshift gvfs --noconfirm

#utilities
pacman -S --needed htop curl tlp neofetch rust wget linux-lts-headers bash-completion sof-firmware appstream mlocate unrar unzip p7zip fuse --noconfirm

#fonts
pacman -S --needed ttf-ubuntu-font-family ttf-opensans ttf-carlito ttf-caladea ttf-liberation ttf-inconsolata ttf-fira-code ttf-fira-mono ttf-fira-sans --noconfirm

#applications
pacman -S --needed firefox vim vlc libreoffice-fresh gimp simple-scan --noconfirm

#network
pacman -S --needed network-manager-applet nss-mdns inetutils net-tools avahi-daemon --noconfirm
systemctl enable avahi-daemon
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#firewall
pacman -S --needed gufw --noconfirm
systemctl enable ufw

#printing and scanning
pacman -S --needed sane cups gutenprint --noconfirm
systemctl enable cups
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#virt manager
pacman -S --needed virt-manager --noconfirm
adduser fabri libvirt
virsh net-autostart default

#grub
sed -i 's/loglevel=3 //g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#set x11 KB language (login manager)
localectl set-x11-keymap it

#various
systemctl disable bluetooth
systemctl enable lightdm
tlp start
