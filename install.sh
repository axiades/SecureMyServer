#!/bin/bash
#Please check the license provided with the script!

source /root/SecureMyServer/configs/sources.cfg

install_start=`date +%s`

progress_gauge "0" "Checking your system..."
set_logs
prerequisites
check_system_before_start

confighelper_userconfig

mkdir /root/SecureMyServer/sources
progress_gauge "0" "Installing System..."
install_system

progress_gauge "1" "Installing OpenSSL..."
install_openssl

progress_gauge "31" "Installing OpenSSH..."
install_openssh

progress_gauge "32" "Installing fail2ban..."
install_fail2ban

install_end=`date +%s`
runtime=$((install_end-install_start))

sed -i 's/SMS_IS_INSTALLED="0"/SMS_IS_INSTALLED="1"/' /root/SecureMyServer/configs/userconfig.cfg

date=$(date +"%d-%m-%Y")
sed -i 's/SMS_INSTALL_DATE="0"/SMS_INSTALL_DATE="'${date}'"/' /root/SecureMyServer/configs/userconfig.cfg
sed -i 's/SMS_INSTALL_TIME_SECONDS="0"/SMS_INSTALL_TIME_SECONDS="'${runtime}'"/' /root/SecureMyServer/configs/userconfig.cfg

start_after_install