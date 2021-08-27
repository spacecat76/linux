#install kde
apt install kde-plasma-desktop libreoffice-writer libreoffice-impress libreoffice-calc libreoffice-plasma libreoffice-style-breeze kamoso okular galculator transmission-qt ark kde-spectacle print-manager ksystemlog kolourpaint gnome-keyring plasma-nm shotwell pavucontrol vlc chromium -y

#remove uneeded kde applications
apt remove konqueror termit kdeconnect kwalletmanager -y

#cleanup
apt autoremove -y

#snap
snap install firefox
snap install --classic code

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
