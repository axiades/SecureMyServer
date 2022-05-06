#!/bin/bash
#Please check the license provided with the script!

start_after_install() {

  trap error_exit ERR

  source /root/SecureMyServer/configs/sources.cfg

  check_openssh && continue_or_exit
  check_fail2ban && continue_or_exit
  check_system && continue_or_exit
  show_ssh_key && continue_or_exit

  dialog_msg "Please save the shown login information on next page"
  cat /root/SecureMyServer/login_information.txt && continue_or_exit

  create_private_key
  continue_or_exit
  
  dialog_msg "Finished after installation configuration"
}