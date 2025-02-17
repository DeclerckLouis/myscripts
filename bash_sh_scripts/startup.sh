#!/bin/sh
## this script should be run as root and should be placed in the data folder (where you'll work)
## it REQUIRES hosts publickey to be added to the github account

# SSH keys from github
apt-get install -y curl git
curl https://github.com/declercklouis.keys > /home/declercklouis/.ssh/authorized_keys
chown declercklouis:declercklouis /home/declercklouis/.ssh/authorized_keys
systemctl restart sshd

# update and upgrade
apt-get update -y
apt-get upgrade -y

# git config
git config --global user.email "declerck.louis@student.howest.be"
git config --global user.name "DeclerckLouis"

# git clones
git clone DeclerckLouis/myscripts myscripts
git clone DeclerckLouis/ansible ansible
git clone DeclerckLouis/docker docker
git clone git@github.com:DeclerckLouis/configs.git configs

# docker installation
## adding docker gpg key
apt-get update
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

## adding docker repository
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y

## installing docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

## adding user to docker group
usermod -aG docker $USER

# ansible installation
apt install -y ansible ansible-lint


# Fail2ban installation
apt-get install -y fail2ban rsyslog
cp configs/fail2ban/jail.conf /etc/fail2ban/jail.d/jail.conf
cp configs/fail2ban/jail.d/* /etc/fail2ban/jail.d/
systemctl restart fail2ban