#install common app
apt install sane cups avahi-daemon printer-driver-all printer-driver-cups-pdf htop curl vim simple-scan tlp net-tools firewalld firewall-config neofetch papirus-icon-theme timeshift ttf-mscorefonts-installer firmware-sof-signed apt-transport-https firmware-realtek intel-microcode stacer make snapd -y

#add user to group
sudo usermod -a -G lpadmin fabri

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#tlp
tlp start

#locale
sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

#services
systemctl disable bluetooth
systemctl enable cups
systemctl enable firewalld
systemctl enable avahi-daemon

#firewall
firewall-cmd --set-default-zone=home