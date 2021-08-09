#install kde applications
pacman -S --needed plasma plasma-wayland-session sddm dolphin konsole okular galculator transmission-qt ark kate spectacle packagekit-qt5 print-manager system-config-printer ksystemlog gnome-keyring --noconfirm

#enable sddm
systemctl enable sddm

#kdewallet
tee -a /home/fabri/.config/kwalletrc  << END
[Wallet]
Enabled=false
END
