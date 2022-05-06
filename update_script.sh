#!/bin/bash
#Please check the license provided with the script!

update_script() {

mkdir -p /opt/backup_sms_server
if [ -d "/root/SecureMyServer/logs/" ]; then
  mkdir -p /opt/backup_sms_server/logs
  mv /root/SecureMyServer/logs/* /opt/backup_sms_server/logs/
fi

if [ -e /root/SecureMyServer/login_information.txt ]; then
  mv /root/SecureMyServer/login_information.txt /opt/backup_sms_server/
fi

if [ -e /root/SecureMyServer/ssh_privatekey.txt ]; then
  mv /root/SecureMyServer/ssh_privatekey.txt /opt/backup_sms_server/
fi

if [ -e /root/SecureMyServer/installation_times.txt ]; then
  mv /root/SecureMyServer/installation_times.txt /opt/backup_sms_server/
fi

if [ -e /root/SecureMyServer/configs/userconfig.cfg ]; then
  mv /root/SecureMyServer/configs/userconfig.cfg /opt/backup_sms_server/
fi

local_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
remote_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
remote=$(git config branch.$local_branch.remote)

dialog_msg "Fetching from ${remote}..."
git fetch $remote

if git merge-base --is-ancestor $remote_branch HEAD; then
  GIT_LOCAL_FILES_HEAD=$(git rev-parse --short HEAD)
  dialog_msg "Already up-to-date Version ${GIT_LOCAL_FILES_HEAD}"
elif git merge-base --is-ancestor HEAD $remote_branch; then
  git stash
  git merge --ff-only --stat $remote_branch
  GIT_LOCAL_FILES_HEAD=$(git rev-parse --short HEAD)
  dialog_msg "Merged to the new Version ${GIT_LOCAL_FILES_HEAD}"
fi

if [ -d "/opt/backup_sms_server/logs/" ]; then
  mv /opt/backup_sms_server/logs/* /root/SecureMyServer/logs/
fi

if [ -e /opt/backup_sms_server/login_information.txt ]; then
  mv /opt/backup_sms_server/login_information.txt /root/SecureMyServer/
fi

if [ -e /opt/backup_sms_server/ssh_privatekey.txt ]; then
  mv /opt/backup_sms_server/ssh_privatekey.txt /root/SecureMyServer/
fi

if [ -e /opt/backup_sms_server/installation_times.txt ]; then
  mv /opt/backup_sms_server/installation_times.txt /root/SecureMyServer/
fi

if [ -e /opt/backup_sms_server/userconfig.cfg ]; then
  mv /opt/backup_sms_server/userconfig.cfg /root/SecureMyServer/configs/
fi

  rm -R /opt/backup_sms_server/
}
