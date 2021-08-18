#install KDE
apt install kde-plasma-desktop libreoffice-kde5 kamoso okular galculator transmission-qt ark kate kde-spectacle print-manager ksystemlog kolourpaint gnome-keyring -y

#remove uneeded KDE applications
apt remove konqueror termit kdeconnect kwrite kwalletmanager -y

#cleanup
apt autoremove -y
