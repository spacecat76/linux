#install xfce4
apt install xfce4 slick-greeter libreoffice-writer libreoffice-impress libreoffice-calc libreoffice-gtk3 libreoffice-style-breeze xfce4-terminal xfce4-power-manager xfce4-taskmanager xfce4-screenshooter xfce4-clipman xfce4-whiskermenu-plugin xfce4-indicator-plugin xfce4-power-manager-plugins xfce4-clipman-plugin network-manager galculator transmission xarchiver thunar-archive-plugin mousepad shotwell vlc mugshot redshift chromium -y

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
