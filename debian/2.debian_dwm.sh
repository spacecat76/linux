#install xfce4
apt install xorg picom dwm slick-greeter xfce4-terminal xfce4-power-manager xfce4-screenshooter network-manager galculator transmission xarchiver thunar thunar-archive-plugin mousepad shotwell redshift libreoffice-gtk vlc nitrogen lxappearance firefox-esr -y

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

#set x11 KB language (lightdm)
localectl set-x11-keymap it

#dark theme
sed -i 's/0/1/g' .config/gtk-3.0/settings.ini

#redshift
cp /home/fabri/Documents/git/linux/etc/dwm/redshift.conf ~/.config




#setting permission to home folder
chown -R fabri:fabri /home/fabri/