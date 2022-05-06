#!/bin/bash
#Please check the license provided with the script!

confighelper_userconfig() {

# --- GLOBAL MENU VARIABLES ---
BACKTITLE="Secure Installation"
TITLE="Secure Installation"
HEIGHT=40
WIDTH=80

CONFIG_COMPLETED="1"

GIT_LOCAL_FILES_HEAD=$(git rev-parse --short HEAD)
rm -rf /root/SecureMySrv/configs/userconfig.cfg
cat >> /root/SecureMySrv/configs/userconfig.cfg <<END
#-----------------------------------------------------------#
############### Config File from Confighelper ###############
#-----------------------------------------------------------#
# This file was created on ${CURRENT_DATE} with Secure Version ${GIT_LOCAL_FILES_HEAD}

CONFIG_COMPLETED="${CONFIG_COMPLETED}"
SMS_IS_INSTALLED="0"
SMS_INSTALL_DATE="0"
SMS_INSTALL_TIME_SECONDS="0"
TIMEZONE="Europe/Berlin"

#-----------------------------------------------------------#
############### Config File from Confighelper ###############
#-----------------------------------------------------------#
END

dialog --title "Userconfig" --exit-label "ok" --textbox /root/SecureMySrv/configs/userconfig.cfg 50 250
clear

CHOICE_HEIGHT=2
MENU="Settings correct?"
OPTIONS=(1 "Yes"
         2 "No")
menu
clear
case $CHOICE in
1)
    #continue
;;
2)
    confighelper_userconfig
;;
esac
}