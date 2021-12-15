#install applications
apt install neofetch htop gnome-photos printer-driver-cups-pdf apt-transport-https python3-pip mlocate code transmission cheese gimp vim ffmpeg gnome-tweaks virtualbox libreoffice-style-breeze -y

#install fonts
apt install ttf-mscorefonts-installer ttf-ubuntu-font-family fonts-crosextra-carlito fonts-crosextra-caladea -y

#firewall
apt install firewalld firewall-config -y
systemctl enable firewalld
firewall-cmd --set-default-zone=home

#scanner
echo "bjnp://192.168.1.94" | tee -a /etc/sane.d/pixma.conf

#services
systemctl disable bluetooth

#swappiness
tee -a /etc/sysctl.conf  << END
vm.swappiness=10
END

#cleanup
apt autoremove -y