#install gnome
apt install gnome-core cheese transmission-gtk file-roller gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks gnome-photos -y

#remove uneeded gnome applications
apt remove malcontent termit -y

#delete gnome extensions
rm -rf /usr/share/gnome-shell/extensions/*

#install dash-to-panel
apt install gnome-shell-extension-dash-to-panel -y

#cleanup
apt autoremove -y

#snap
snap install --classic code
snap install libreoffice

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
apt install /home/fabri/Downloads/google-chrome-stable_current_amd64.deb -y
rm /home/fabri/Downloads/*.deb

#network manager
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

#setting permission to home folder
chown -R fabri:fabri /home/fabri/
