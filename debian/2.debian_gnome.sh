#install gnome
apt install gnome-core avahi-daemon network-manager-gnome libreoffice-gnome cheese transmission-gtk file-roller gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks gnome-photos firefox-esr -y

#remove uneeded gnome applications
apt remove malcontent gnome-contacts termit -y

#delete gnome extensions
rm -rf /usr/share/gnome-shell/extensions/*

#install dash-to-panel
apt install gnome-shell-extension-dash-to-panel -y

#cleanup
apt autoremove -y

#snap
snap install code libreoffice
sudo ln -s /var/lib/snapd/desktop/applications /usr/share/applications/snapd

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
apt install /home/fabri/Downloads/google-chrome-stable_current_amd64.deb -y
rm /home/fabri/Downloads/*.deb

#setting permission to home folder
chown -R fabri:fabri /home/fabri/