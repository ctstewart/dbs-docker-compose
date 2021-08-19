#!/usr/bin/env bash

echo ""
echo "This script does two things:"
echo ""
echo "1. Installs nginx, creates a .conf file, and adds ssl."
echo "2. Creates a service for the docker-compose file so it will run at startup."
echo ""
echo "ONLY RUN THIS IF YOU ARE ON A LINUX PRODUCTION DISTRO (UBUNTU 20.04),"
echo "IF YOU ARE ROOT PRIVELAGES,"
echo "AND IF YOU HAVE COMPLETED THE OTHER STEPS IN THE README."
echo ""
echo "Continue? (y/N)"

read continue

if [[ $continue == 'y' ]]; then
    apt update
    apt upgrade -y
    cp ./config/docker-compose-dbs.service /etc/systemd/system/docker-compose-dbs.service
    systemctl enable docker-compose-dbs
    apt install nginx
    cp ./config/nginx.conf /etc/nginx/conf.d/default.conf
    nginx -s reload
    snap install core -y
    snap refresh core
    snap install --classic certbot
    certbot --nginx
    reboot
fi