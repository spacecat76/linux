# update repositories
apt update && apt upgrade -y

# firmware
apt install firmware-linux firmware-sof-signed firmware-realtek -y

# desktop environment
apt install i3 polybar slick-greeter thunar thunar-archive-plugin lxterminal xfce4-screenshooter mousepad redshift transmission-gtk nitrogen gnome-keyring shotwell galculator light xbindkeys gvfs-backends ffmpegthumbnailer tumbler tumbler-plugins-extra upower xss-lock lm-sensors gtk2-engines-pixbuf firefox-esr -y

# apps & utilities
apt install tlp gimp vim htop neofetch timeshift unrar net-tools curl build-essential apt-transport-https apt-file -y

# audio
apt install pulseaudio pavucontrol vlc ffmpeg ffmpegfs libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-pulseaudio libcanberra-pulse -y

# fonts & icons
apt install ttf-mscorefonts-installer fonts-ubuntu fonts-crosextra-carlito fonts-crosextra-caladea fonts-firacode papirus-icon-theme -y

# network
apt install network-manager avahi-daemon ufw -y
systemctl enable avahi-daemon
systemctl enable ufw --now
ufw enable
ufw allow mdns
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf
sed -i 's/Before=network.target/Before=network-pre.target/g' /lib/systemd/system/ufw.service
sed -i 's/DefaultDependencies=no/Wants=network-pre.target/g' /lib/systemd/system/ufw.service

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

# vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt update && apt install code -y

# flatpak
apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark org.libreoffice.LibreOffice -y
ln -s /var/lib/flatpak/exports/bin/org.libreoffice.LibreOffice /usr/bin/libreoffice

# locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

# grub
sed -i 's/quiet/quiet loglevel=3/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=2/g' /etc/default/grub
update-grub

# fastgate
apt install cifs-utils smbclient -y
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END

# touchpad
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

# Intel Graphics
tee -a /etc/X11/xorg.conf.d/20-intel-gpu.conf << END
Section "Device"
        Identifier  "Intel Graphics"
        Driver      "intel"
        Option      "TearFree"  "true"
        Option      "DRI"    "3"
EndSection
END
echo "dev.i915.perf_stream_paranoid = 0" | tee /etc/sysctl.d/99-i915.conf

# greeter
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=slick-greeter/g' /etc/lightdm/lightdm.conf
tee -a /etc/lightdm/slick-greeter.conf << END
[Greeter]
background=/home/fabri/Git/linux/img/greeter.png
END
sed -i 's/ConditionUser=!root/ConditionUser=!lightdm/g' /usr/lib/systemd/user/pulseaudio.socket
sed -i 's/ConditionUser=!root/ConditionUser=!lightdm/g' /usr/lib/systemd/user/pulseaudio.service

# power management
tlp start

# dmenu
cp /usr/bin/lxterminal /usr/local/bin/terminal
cp /usr/bin/xfce4-screenshooter /usr/local/bin/screenshooter
cp /usr/bin/galculator /usr/local/bin/calculator
cp /usr/bin/virt-manager /usr/local/bin/virtual

## Debian 11
# purge components
apt purge avahi-autoipd bluez -y
apt autoremove -y

# disable pipewire
systemctl disable --global pipewire
rm -rf /home/fabri/.config/pulse

# swappiness
tee -a /etc/sysctl.conf  << END
vm.swappiness=10
END

# iwlwifi
tee -a /etc/modprobe.d/iwlwifi.conf  << END
options iwlwifi enable_ini=N
END
