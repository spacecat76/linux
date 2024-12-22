# update repositories
apt update && apt upgrade -y

# locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
sed -i 's/en_US.UTF-8/it_IT.UTF-8/g' /etc/default/locale
sed -i 's/LANG=it_IT.UTF-8/LANG=en_US.UTF-8/g' /etc/default/locale

# firmware
apt install firmware-linux firmware-sof-signed firmware-realtek -y

# firefox
install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
apt update && apt install firefox -y

# desktop environment
apt install xfce4 xfce4-goodies tlp mugshot menulibre bluez bluetooth slick-greeter lightdm-settings redshift-gtk light xbindkeys gvfs-backends ffmpegthumbnailer tumbler tumbler-plugins-extra -y

# apps & utilities
apt install timeshift vim htop neofetch unrar net-tools curl apt-file plymouth-themes apt-transport-https gparted transmission-gtk shotwell seahorse cheese galculator -y

# docklite
wget https://mxrepo.com/mx/repo/pool/main/x/xfce4-docklike-plugin/xfce4-docklike-plugin_0.4.0+git20211128-1~mx21+1_amd64.deb
apt install ./xfce4-docklike-plugin_0.4.0+git20211128-1~mx21+1_amd64.deb -y
rm -r ./xfce4*.deb

# multimedia
apt install vlc ffmpeg ffmpegfs libavcodec-extra gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly -y

# fonts & icons
apt install papirus-icon-theme deepin-icon-theme ttf-mscorefonts-installer fonts-ubuntu fonts-crosextra-carlito fonts-crosextra-caladea -y

# vcode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt update && apt install code -y

# chrome
curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg >> /dev/null
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list
apt update && apt install google-chrome-stable -y

# onlyoffice
mkdir -p -m 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
chown root:root /tmp/onlyoffice.gpg
mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg
echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
apt update && apt install onlyoffice-desktopeditors -y

# spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt update && apt install spotify-client -y

# network
apt install ufw network-manager-gnome -y
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf
ufw enable
ufw allow mdns
set timedatectl set-ntp true
set timedatectl set-timezone "Europe/Rome"

# cockpit
apt install cockpit cockpit-podman cockpit-machines bridge-utils pcp -y
adduser fabri libvirt
virsh net-autostart default
sed -i 's/#user = "libvirt-qemu"/user = "fabri"/g' /etc/libvirt/qemu.conf
sed -i 's/#group = "libvirt-qemu"/group = "libvirt"/g' /etc/libvirt/qemu.conf

# printing and scanning
apt install sane cups printer-driver-all printer-driver-cups-pdf simple-scan -y
adduser fabri lpadmin

# grub
sed -i 's/quiet/quiet loglevel=3 splash/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=2/g' /etc/default/grub
update-grub

# plymouth themes
plymouth-set-default-theme -R lines

# lid setting
sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/g' /etc/systemd/logind.conf
sed -i 's/#HandleLidSwitchExternalPower=suspend/HandleLidSwitchExternalPower=ignore/g' /etc/systemd/logind.conf

# fastgate
apt install cifs-utils smbclient -y
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin,x-systemd.after=network-online.target,x-systemd.automount,user 0 0
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

# greeter
sed -i 's/ConditionUser=!root/ConditionUser=!lightdm/g' /usr/lib/systemd/user/pulseaudio.socket
sed -i 's/ConditionUser=!root/ConditionUser=!lightdm/g' /usr/lib/systemd/user/pulseaudio.service

# tumbler
sed -i '/MaxFileSize=/c\MaxFileSize=0' /etc/xdg/tumbler/tumbler.rc

# various
sed -i 's/#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=30s/g' /etc/systemd/system.conf
sed -i 's/#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=30s/g' /etc/systemd/user.conf

tlp start
