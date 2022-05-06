#!/bin/bash
#Please check the license provided with the script!

update_fail2ban() {

trap error_exit ERR

source /root/SecureMySrv/configs/sources.cfg

LOCAL_FAIL2BAN_VERSION_STRING=$(fail2ban-client --version)
LOCAL_FAIL2BAN_VERSION=$(echo $LOCAL_FAIL2BAN_VERSION_STRING | cut -c11-16)

if [[ ${LOCAL_FAIL2BAN_VERSION} != ${FAIL2BAN_VERSION} ]]; then
  install_packages "python"

  mkdir -p /root/SecureMySrv/sources/${FAIL2BAN_VERSION}/
  cd /root/SecureMySrv/sources/${FAIL2BAN_VERSION}/

  wget_tar "https://codeload.github.com/fail2ban/fail2ban/tar.gz/${FAIL2BAN_VERSION}"
  tar_file "${FAIL2BAN_VERSION}"
  cd fail2ban-${FAIL2BAN_VERSION}

  python setup.py -q install

  cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
  cp /root/SecureMySrv/configs/fail2ban/jail.local /etc/fail2ban/jail.local

  cp files/debian-initd /etc/init.d/fail2ban
  update-rc.d fail2ban defaults
  systemctl -q start fail2ban

  rm -R /root/SecureMySrv/sources/${FAIL2BAN_VERSION}
fi
}