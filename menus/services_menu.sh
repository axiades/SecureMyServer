#!/bin/bash
#Please check the license provided with the script!

menu_options_services() {

source /root/SecureMyServer/configs/sources.cfg
set_logs

HEIGHT=40
WIDTH=80
CHOICE_HEIGHT=5
BACKTITLE="Secure"
TITLE="Secure"
MENU="Choose one of the following options:"

OPTIONS=(1 "Openssh Options"
         2 "Back"
         3 "Exit")

CHOICE=$(dialog --clear \
                --nocancel \
                --no-cancel \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in

1)
menu_options_openssh
;;

2)
bash /root/SecureMyServer/start.sh
;;

3)
echo "Exit"
exit
;;
esac
}
