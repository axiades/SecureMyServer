#!/bin/bash
#Please check the license provided with the script!

clear
echo "Secure"
echo "Preparing menu..."

if [ $(dpkg-query -l | grep dialog | wc -l) -ne 3 ]; then
    apt -qq install dialog >/dev/null 2>&1
fi

source /root/SecureMySrv/configs/sources.cfg

GIT_LOCAL_FILES_HEAD=$(git rev-parse --short HEAD)
GIT_LOCAL_FILES_HEAD_LAST_COMMIT=$(git log -1 --date=short --pretty=format:%cd)

HEIGHT=40
WIDTH=80
CHOICE_HEIGHT=8
BACKTITLE="Secure"
TITLE="Secure"
MENU="\n Choose one of the following options: \n \n"

OPTIONS=(1 "Install Secure Version: ${GIT_LOCAL_FILES_HEAD} - ${GIT_LOCAL_FILES_HEAD_LAST_COMMIT}"
         2 "After Installation configuration"
         3 "Update Secure Installation"
         4 "Update Secure Script Code Base"
         5 "Services Options"
         6 "Exit")

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
if [[ ${SMS_IS_INSTALLED} == '1' ]]; then
    echo "The Secure Script is already installed!"
    continue_to_menu
else
    bash install.sh
fi
;;

2)
if [[ ${SMS_IS_INSTALLED} == '1' ]]; then
    menu_options_after_install
else
    echo "Please install the Secure Script before starting the configuration!"
    continue_to_menu
fi
;;

3)
if [[ ${SMS_IS_INSTALLED} == '1' ]]; then
    update_all_services
else
    echo "You have to install the Secure to run the services update!"
    continue_to_menu
fi
;;

4)
dialog_info "Updating Secure Script"
update_script
bash start.sh
;;

5)
if [[ ${SMS_IS_INSTALLED} == '1' ]]; then
    menu_options_services
else
    echo "You have to install the Secure to run the services options!"
    continue_to_menu
fi
;;

6)
echo "Exit"
exit
;;
esac
