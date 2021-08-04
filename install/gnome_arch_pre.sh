#install applications
pacman -S --needed gnome-shell gdm gnome-control-center gnome-terminal gnome-software gnome-software-packagekit-plugin file-roller gedit nautilus gnome-tweaks nano firefox sane cups nss-mdns htop curl vim cheese gnome-calculator shotwell vlc gnome-screenshot gnome-logs tracker gnome-system-monitor evince transmission-gtk simple-scan libreoffice tlp net-tools chromium ufw fuse gutenprint neofetch rust wget virtualbox gnome-keyring linux-headers xdg-user-dirs gnome-weather ttf-ubuntu-font-family papirus-icon-theme --noconfirm

#set aliases
tee -a /home/fabri/.bashrc  << END
alias ls="ls -lha --color"
END

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#printer
sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' /etc/nsswitch.conf

#services
systemctl disable bluetooth
systemctl disable iptables.service
systemctl enable gdm
systemctl enable avahi-daemon.service
systemctl enable cups

#ufw
ufw enable
ufw allow 5353/udp
systemctl enable ufw

#tlp
tlp start

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
