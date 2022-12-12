# create directories
mkdir -p ~/.config/{i3,polybar/scripts,lxterminal,gtk-3.0,systemd/user,Thunar,picom,volumeicon}

# copy files
cp ~/Git/linux/.config/i3/config ~/.config/i3/config
cp ~/Git/linux/.config/polybar/config ~/.config/polybar/config
cp ~/Git/linux/.config/polybar/launch.sh ~/.config/polybar/launch.sh
cp ~/Git/linux/.config/polybar/scripts/updates.sh ~/.config/polybar/scripts/updates.sh
cp ~/Git/linux/.config/lxterminal/lxterminal.conf ~/.config/lxterminal/lxterminal.conf
cp ~/Git/linux/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
cp ~/Git/linux/.config/Thunar/uca.xml ~/.config/Thunar/uca.xml
cp ~/Git/linux/.config/picom/picom.conf ~/.config/picom/picom.conf
cp ~/Git/linux/.config/volumeicon/volumeicon ~/.config/volumeicon/volumeicon
cp ~/Git/linux/.config/systemd/user/redshift.service ~/.config/systemd/user/redshift.service
cp ~/Git/linux/.config/redshift.conf ~/.config/redshift.conf

# start redshift user service
systemctl --user enable redshift

# polybar
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/*.sh

# user dirs
xdg-user-dirs-update
