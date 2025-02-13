#!/bin/sh

# Check if run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Check username and hostname
echo "Username: $USER"
echo "Hostname: $HOSTNAME"
echo ""

# General update, upgrade and dependencies
apt-get update
apt-get upgrade -y
apt-get install -y curl git


