# update repositories
apt update && apt upgrade -y

# firmware
apt install firmware-linux firmware-sof-signed firmware-realtek -y

# desktop environment
apt install lxterminal i3 polybar picom slick-greeter thunar thunar-archive-plugin seahorse light xbindkeys gvfs-backends ffmpegthumbnailer tumbler tumbler-plugins-extra upower xss-lock lm-sensors gtk2-engines-pixbuf dbus-x11 rofi policykit-1-gnome mousetweaks -y

# apps & utilities
apt install tlp flameshot vim htop neofetch timeshift unrar net-tools curl apt-transport-https apt-file mousepad redshift transmission-gtk nitrogen shotwell galculator plymouth-themes wmctrl libnotify-bin -y

# audio
apt install pipewire pipewire-alsa pipewire-jack pipewire-audio wireplumber pipewire-pulse pipewire-alsa pavucontrol -y 

# multimedia
apt install vlc ffmpeg ffmpegfs libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly -y

# fonts & icons
apt install fonts-font-awesome ttf-mscorefonts-installer fonts-ubuntu fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode papirus-icon-theme -y

# network
apt install network-manager-gnome avahi-daemon firewalld -y
systemctl enable avahi-daemon
cp /home/fabri/Git/linux/etc/ffw.xml /usr/lib/firewalld/zones
firewall-cmd --reload
firewall-cmd --set-default-zone ffw
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

# virt manager
apt install virt-manager -y
adduser fabri libvirt
virsh net-autostart default

# printing and scanning
apt install sane cups printer-driver-all printer-driver-cups-pdf simple-scan -y
systemctl enable cups
usermod -a -G lpadmin fabri
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

# google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri
apt install /home/fabri/google-chrome-stable_current_amd64.deb -y
rm -f /home/fabri/google-chrome-stable_current_amd64.deb

# snaps
apt install snapd -y
snap install core firefox gimp pinta onlyoffice-desktopeditors
snap install code --classic

# locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

# grub
sed -i 's/quiet/quiet loglevel=3 splash/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=2/g' /etc/default/grub
update-grub

# fastgate
apt install cifs-utils smbclient -y
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END

# touchpad X11
tee -a /etc/X11/xorg.conf.d/90-touchpad.conf << END
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "TappingButtonMap" "lrm"
        Option "NaturalScrolling" "on"
        Option "ScrollMethod" "twofinger"
EndSection
END

# intel graphics X11
# tee -a /etc/X11/xorg.conf.d/20-intel-gpu.conf << END
# Section "Device"
#        Identifier  "Intel Graphics"
#        Driver      "intel"
#        Option      "TearFree"  "true"
#        Option      "DRI"    "3"
# EndSection
# END

# picom
tee -a /etc/X11/xorg.conf << END
Section "Extensions"
        Option  "Composite" "true"
EndSection
END

# greeter
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=slick-greeter/g' /etc/lightdm/lightdm.conf
sed -i 's/#greeter-hide-users=false/greeter-hide-users=false/g' /etc/lightdm/lightdm.conf
sed -i 's/#allow-user-switching=true/allow-user-switching=true/g' /etc/lightdm/lightdm.conf

tee -a /etc/lightdm/slick-greeter.conf << END
[Greeter]
background=/home/fabri/Git/linux/img/greeter.png
END

# plymouth themes
plymouth-set-default-theme -R lines

# thumbler
sed -i '/MaxFileSize=/c\MaxFileSize=0' /etc/xdg/tumbler/tumbler.rc

# power management
tlp start

# dmenu
ln -s /var/lib/flatpak/exports/bin/org.libreoffice.LibreOffice /usr/bin/libreoffice

# swappiness
tee -a /etc/sysctl.conf  << END
vm.swappiness=10
END

# enable services
systemctl enable cups avahi-daemon firewalld wireplumber.service

# purge components
# apt purge avahi-autoipd rxvt-unicode -y
apt autoremove -y
