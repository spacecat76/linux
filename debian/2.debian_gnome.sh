#install gnome
apt install gnome-core avahi-daemon network-manager-gnome libreoffice-gnome cheese transmission-gtk file-roller gnome-screenshot gnome-tweaks gnome-weather gnome-calendar gnome-clocks gnome-photos -y

#remove uneeded gnome applications
sudo apt remove malcontent gnome-contacts termit

#delete gnome extensions
rm -rf /usr/share/gnome-shell/extensions/*

#install dash-to-panel
apt install gnome-shell-extension-dash-to-panel -y

#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /home/fabri/Downloads
apt install /home/fabri/Downloads/google-chrome-stable_current_amd64.deb -y
rm /home/fabri/Downloads/*.deb

#cleanup
apt autoremove -y

#setting permission to home folder
chown -R fabri:fabri /home/fabri/