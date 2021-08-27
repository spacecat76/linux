#install KDE
apt install kde-plasma-desktop libreoffice-kde5 kamoso okular galculator transmission-qt ark kde-spectacle print-manager ksystemlog kolourpaint gnome-keyring plasma-nm shotwell pavucontrol vlc chromium -y

#remove uneeded KDE applications
apt remove konqueror termit kdeconnect kwalletmanager -y

#cleanup
apt autoremove -y

#snap
snap install firefox code libreoffice
sudo ln -s /var/lib/snapd/desktop/applications /usr/share/applications/snapd

#kdewallet
tee -a /home/fabri/.config/kwalletrc  << END
Enabled=false
END

#touchpad X11
tee -a /etc/X11/xorg.conf.d/30-touchpad.conf  << END
Section "InputClass"
Identifier "touchpad"
Driver "libinput"
  MatchIsTouchpad "on"
  Option "Tapping" "on"
  Option "NaturalScrolling" "on"
  Option "ClickMethod" "clickfinger"
EndSection
END

#setting permission to home folder
chown -R fabri:fabri /home/fabri/

#set x11 KB language (SDDM)
localectl set-x11-keymap it
