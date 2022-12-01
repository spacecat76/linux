# create directories
mkdir -p ~/.config/{i3,i3blocks,xfce4/terminal,gtk-3.0,systemd/user}

# copy files
cp ~/Git/linux/.config/i3/config ~/.config/i3/config
cp ~/Git/linux/.config/i3block/config ~/.config/i3blocks/config
cp ~/Git/linux/.config/xfce4/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
cp ~/Git/linux/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
cp ~/Git/linux/.config/systemd/user/redshift.service ~/.config/systemd/user/redshift.service
cp ~/Git/linux/.config/re.conf ~/.config/redshift.conf

# start redshift user service
systemctl --user enable redshift
