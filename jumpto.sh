#jumpto
function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
start=${1:-"start"}

jumpto $start

#de selection
start:
echo "Which DE would you like to install? (gnome, kde, none or exit)"
read de
if [[ $de == "gnome" ]] || [[ $de == "kde" ]] || [[ $de == "none" ]]; then
   jumpto install
elif [[ $de == "exit" ]]; then
   exit
else
   jumpto start
fi
install:

#de install
if [[ $de == "gnome" ]]; then
   jumpto gnome
elif [[ $de == "kde" ]]; then
   jumpto kde
else
   jumpto final
fi

gnome:

jumpto final

kde:

final:


