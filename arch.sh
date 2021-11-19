#install applications
pacman -S --needed firefox sane cups nss-mdns htop curl vim vlc libreoffice-fresh tlp net-tools firewalld fuse gutenprint neofetch rust wget linux-lts-headers bash-completion sof-firmware appstream gimp virtualbox flatpak simple-scan mlocate unrar inetutils --noconfirm

#install fonts
pacman -S --needed ttf-ubuntu-font-family ttf-opensans ttf-carlito ttf-caladea ttf-liberation ttf-inconsolata ttf-fira-code ttf-fira-mono ttf-fira-sans --noconfirm

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf

#grub
sed -i 's/loglevel=3 //g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl enable cups
systemctl enable firewalld
systemctl enable avahi-daemon

#firewall
firewall-cmd --set-default-zone=home

#install kde
pacman -S --needed plasma plasma-wayland-session plasma-wayland-protocols sddm dolphin konsole okular galculator transmission-qt ark kate spectacle packagekit-qt5 print-manager system-config-printer ksystemlog partitionmanager kamoso gwenview kwallet-pam kwalletmanager kdevelop --noconfirm

#remove kde applications
pacman -R plasma-browser-integration plasma-firewall --noconfirm

#install flatpak
flatpak install flathub org.gtk.Gtk3theme.Breeze-Dark io.gitlab.librewolf-community -y
flatpak override --env=GTK_THEME=Breeze-Dark

#enable sddm
systemctl enable sddm

#set x11 KB language (login manager)
localectl set-x11-keymap it

#touchpad X11
tee -a /etc/X11/xorg.conf.d/30-touchpad.conf  << END
Section "InputClass"
Identifier "touchpad"
Driver "libinput"
  MatchIsTouchpad "on"
  Option "Tapping" "on"
  Option "NaturalScrolling" "on"
  Option "ClickMethod" "clickfinger"
EndSection
END

#setting permission to home folder
chown -R fabri:fabri /home/fabri/

