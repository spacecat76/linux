# create directories
mkdir -p ~/.config/{i3,i3blocks,lxterminal,gtk-3.0,systemd/user}

# copy files
cp ~/Git/linux/.config/i3/config ~/.config/i3/config
cp ~/Git/linux/.config/i3blocks/config ~/.config/i3blocks/config
cp ~/Git/linux/.config/lxterminal/lxterminal.conf ~/.config/lxterminal/lxterminal.conf
cp ~/Git/linux/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
cp ~/Git/linux/.config/systemd/user/redshift.service ~/.config/systemd/user/redshift.service
cp ~/Git/linux/.config/redshift.conf ~/.config/redshift.conf

# start redshift user service
systemctl --user enable redshift

# gnome network manager
gsettings set org.gnome.nm-applet disable-connected-notifications "true"
gsettings set org.gnome.nm-applet disable-disconnected-notifications "true"
