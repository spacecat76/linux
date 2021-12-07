#install applications
apt install timeshift neofetch htop gnome-photos printer-driver-cups-pdf apt-transport-https python3-pip mlocate code transmission cheese gimp vim ffmpeg vlc -y

#install fonts
apt install ttf-mscorefonts-installer ttf-ubuntu-font-family fonts-crosextra-carlito fonts-crosextra-caladea -y

#virt manager
apt install virt-manager --no-install-recommends -y
adduser fabri libvirt
virsh net-autostart default

#firewall
apt install firewalld firewall-config -y
systemctl enable firewalld
firewall-cmd --set-default-zone=home

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#services
systemctl disable bluetooth

#cleanup
apt autoremove -y