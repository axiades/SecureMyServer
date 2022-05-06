#!/bin/bash
#Please check the license provided with the script!

update_all_services() {

trap error_exit ERR

source /root/SecureMySrv/configs/sources.cfg

#updating script code base before updating the server!
update_script

if [[ ${SMS_IS_INSTALLED} == '1' ]]; then
  echo "0" | dialog --gauge "Updating package lists..." 10 70 0
  apt update >/dev/null 2>&1

  echo "5" | dialog --gauge "Upgrading packages..." 10 70 0
  apt -y upgrade >/dev/null 2>&1

  echo "8" | dialog --gauge "Upgrading Debian..." 10 70 0
  apt -y dist-upgrade >/dev/null 2>&1

  echo "12" | dialog --gauge "Updating fail2ban..." 10 70 0
  update_fail2ban

  echo "30" | dialog --gauge "Updating Openssl..." 10 70 0
  update_openssl

  dialog_msg "Finished updating all services"
else
  echo "The Secure Script is not installed, nothing to update..."
fi
}