#install gnome applications
pacman -S --needed firefox sane cups nss-mdns htop curl vim cheese shotwell vlc simple-scan libreoffice tlp net-tools chromium ufw fuse gutenprint neofetch rust wget virtualbox linux-lts-headers ttf-ubuntu-font-family papirus-icon-theme bash-completion sof-firmware --noconfirm

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf

#ufw
ufw enable

#tlp
tlp start

#services
systemctl disable bluetooth
systemctl disable iptables
systemctl enable avahi-daemon
systemctl enable cups
systemctl enable ufw
