#install the KDE desktop environment
apt install kde-plasma-desktop libreoffice-kde5 kamoso okular galculator transmission-qt ark kate kde-spectacle packagekit-qt5 print-manager ksystemlog kolourpaint gnome-keyring -y

#remove uneeded applications
apt remove konqueror termit kdeconnect kwrite kwalletmanager -y

#cleanup
apt autoremove -y
