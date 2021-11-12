#install applications
pacman -S --needed firefox sane cups nss-mdns htop curl vim cheese vlc simple-scan libreoffice tlp net-tools firewalld fuse gutenprint neofetch rust wget linux-lts-headers ttf-ubuntu-font-family papirus-icon-theme bash-completion sof-firmware appstream gimp --noconfirm

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl enable firewalld
systemctl enable avahi-daemon
systemctl enable cups

#firewall
firewall-cmd --set-default-zone=home

#install kde applications
pacman -S --needed plasma sddm thunar konsole okular galculator transmission-qt ark kate spectacle packagekit-qt5 print-manager system-config-printer ksystemlog kdevelop shotwell partitionmanager --noconfirm

#enable sddm
systemctl enable sddm

#set x11 KB language (login manager)
localectl set-x11-keymap it

#setting permission to home folder
chown -R fabri:fabri /home/fabri/

