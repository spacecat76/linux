#install applications
pacman -S --needed firefox sane cups nss-mdns htop curl vim vlc libreoffice-fresh tlp net-tools firewalld fuse gutenprint neofetch rust wget linux-lts-headers ttf-ubuntu-font-family bash-completion sof-firmware appstream gimp virtualbox flatpak --noconfirm

#simple-scan shotwell

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

#install kde applications
pacman -S --needed plasma sddm dolphin konsole okular galculator transmission-qt ark kate spectacle packagekit-qt5 print-manager system-config-printer ksystemlog kdevelop partitionmanager kamoso --noconfirm

#remove kde application
pacman -R plasma-browser-integration plasma-firewall -y

#install flatpak
flatpak install flathub org.gtk.Gtk3theme.Breeze-Dark io.gitlab.librewolf-community -y

#enable sddm
systemctl enable sddm

#set x11 KB language (login manager)
localectl set-x11-keymap it

#setting permission to home folder
chown -R fabri:fabri /home/fabri/

