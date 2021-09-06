#install xfce4
apt install dwm slick-greeter thunar libreoffice-gtk3 xfce4-terminal network-manager galculator transmission xarchiver thunar-archive-plugin mousepad shotwell vlc redshift chromium lxappereance -y

#cleanup
apt autoremove -y

#snap
snap install firefox
snap install --classic code
ln -s /var/lib/snapd/desktop/applications /usr/share/applications/snapd

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