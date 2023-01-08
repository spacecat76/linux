#!/bin/bash
n1=$(apt list --upgradable | wc -l)
n2=$[ n1 - 1 ]
if [ $n2 -ne 0 ];
then
    notify-send -t 30000 -i /usr/share/icons/Papirus-Dark/128x128/apps/update-notifier.svg "UPDATES" "There are $n2 updates available"
fi
echo $n2