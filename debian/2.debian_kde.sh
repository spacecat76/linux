#install KDE
apt install kde-plasma-desktop libreoffice-kde5 kamoso okular galculator transmission-qt ark kate kde-spectacle print-manager ksystemlog kolourpaint gnome-keyring  plasma-nm -y

#remove uneeded KDE applications
apt remove konqueror termit kdeconnect kwrite kwalletmanager -y

#cleanup
apt autoremove -y

#kdewallet
tee -a /home/fabri/.config/kwalletrc  << END
Enabled=false
END

#setting permission to home folder
chown -R fabri:fabri /home/fabri/

#set x11 KB language (SDDM)
localectl set-x11-keymap it