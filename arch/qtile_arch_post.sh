#!/bin/bash

#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#aur
paru -S ttf-ms-fonts timeshift visual-studio-code-bin lightdm-slick-greeter --noconfirm

#redshift
tee -a /home/fabri/.config/redshift.conf  << END
[redshift]
location-provider=manual
dawn-time=09:00
dusk-time=20:00
END