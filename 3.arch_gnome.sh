#install gnome applications
pacman -S --needed gnome-shell gdm gnome-control-center gnome-terminal gnome-software gnome-software-packagekit-plugin file-roller gedit nautilus gnome-tweaks gnome-calculator gnome-screenshot gnome-logs tracker gnome-system-monitor evince transmission-gtk gnome-weather gnome-photos --noconfirm

#enable gdm
systemctl enable gdm
