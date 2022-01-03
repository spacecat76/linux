#xfce4
pacman -S xfce4 xfce4-dev-tools xorg-server-xephyr xfce4-screenshooter xfce4-terminal xarchiver thunar-archive-plugin transmission-gtk xfce4-battery-plugin xfce4-datetime-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-whiskermenu-plugin gthumb galculator mousepad gparted redshift gvfs gnome-keyring geary --noconfirm

#lightdm
pacman -S --needed lightdm lightdm-gtk-greeter lightdm-slick-greeter --noconfirm
systemctl enable lightdm
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-slick-greeter/g' /etc/lightdm/lightdm.conf

#utilities
pacman -S --needed htop curl tlp neofetch rust wget linux-headers bash-completion sof-firmware appstream mlocate unrar unzip p7zip fuse ffmpeg --noconfirm

#fonts
pacman -S --needed ttf-ubuntu-font-family ttf-opensans ttf-carlito ttf-caladea ttf-liberation ttf-inconsolata ttf-fira-code ttf-fira-mono ttf-fira-sans --noconfirm

#applications
pacman -S --needed firefox chromium virtualbox vim nano vlc libreoffice-fresh gimp --noconfirm

#network
pacman -S --needed network-manager-applet nss-mdns inetutils net-tools avahi --noconfirm
systemctl enable avahi-daemon
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#firewall
pacman -S firewalld --noconfirm
systemctl enable firewalld
firewall-cmd --set-default-zone=home

#printing and scanning
pacman -S --needed sane cups gutenprint simple-scan --noconfirm
systemctl enable cups
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#various
tlp start
