#!/bin/bash
#Please check the license provided with the script!

check_system_before_start() {

trap error_exit ERR

local Su_user=$(whoami)
[ "$Su_user" != 'root' ] && error_exit "Please run the script as root user"

[ $(lsb_release -is) != 'Ubuntu' ] && [ $(lsb_release -cs) != 'Focal' ] && error_exit "Please run the Script with Ubuntu Focal"

local LOCAL_KERNEL_VERSION=$(uname -a | awk '/Linux/ {print $(NF-12)}')
[ $LOCAL_KERNEL_VERSION != ${KERNEL_VERSION} ] && kernel_check_failed

[ $(grep MemTotal /proc/meminfo | awk '{print $2}') -lt 512000 ] && error_exit "This script needs at least ~512MB Ram"

local FREE=`df -k --output=avail "$PWD" | tail -n1`
[ $FREE -lt 2097151 ] && error_exit "This script needs at least 2 GB free disk space"

[ $(dpkg-query -l | grep dmidecode | wc -l) -ne 1 ] && error_exit "This script does not support your virtualization technology!"

if [ "$(dmidecode -s system-product-name)" == 'Bochs' ] || [ "$(dmidecode -s system-product-name)" == 'KVM' ] || [ "$(dmidecode -s system-product-name)" == 'All Series' ] || [ "$(dmidecode -s system-product-name)" == 'OpenStack Nova' ] || [ "$(dmidecode -s system-product-name)" == 'Standard' ]; then
   echo > /dev/null
else
    if [ $(dpkg-query -l | grep facter | wc -l) -ne 1 ]; then
       install_packages "facter libruby"
    fi
    if [ "$(facter virtual)" == 'physical' ] || [ "$(facter virtual)" == 'kvm' ] || [ "$(facter virtual)" == 'xenu' ]; then
       echo > /dev/null
    else
       echo "This script does not support the virtualization technology ($(dmidecode -s system-product-name))"
       exit 1
    fi
fi
}
