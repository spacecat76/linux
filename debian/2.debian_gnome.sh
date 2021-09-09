#install gnome
apt install gnome-core cheese transmission-gtk file-roller gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks gnome-photos -y

#libreoffice-gnome

#remove uneeded gnome applications
apt remove malcontent termit -y

#delete gnome extensions
rm -rf /usr/share/gnome-shell/extensions/*

#install dash-to-panel
apt install gnome-shell-extension-dash-to-panel -y

#cleanup
apt autoremove -y

#network manager
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
