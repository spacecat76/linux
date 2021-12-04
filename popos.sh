#install applications
apt install ttf-mscorefonts-installer timeshift neofetch htop gnome-photos printer-driver-cups-pdf firewalld firewall-config apt-transport-https python3-pip fonts-crosextra-carlito fonts-crosextra-caladea mlocate code transmission cheese virt-manager google-chrome-stable -y

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#services
systemctl disable bluetooth
systemctl enable firewalld

#firewall
firewall-cmd --set-default-zone=home

#cleanup
apt autoremove -y

