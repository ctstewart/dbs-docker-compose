#!/usr/bin/env bash

echo ""
echo "This script does three things:"
echo ""
echo "1. Installs nginx, creates a .conf file, and adds ssl."
echo "2. Creates a service for the docker-compose file so it will run at startup."
echo "3. Writes the env variables to the correct files."
echo ""
echo "ONLY RUN THIS IF YOU ARE ON A LINUX PRODUCTION DISTRO (UBUNTU 20.04),"
echo "IF YOU ARE ROOT PRIVELAGES,"
echo "AND IF YOU HAVE COMPLETED THE OTHER STEPS IN THE README."
echo ""
echo "Continue? (y/N)"

read runScript

if [[ $runScript == 'y' ]]; then
    apt update
    apt upgrade -y
    apt install npm

    echo 'Enter "production" or "development".'
    read nodeEnv
    echo "Enter your domain (include http(s))."
    read domain
    echo "Enter the Auth0 domain."
    read auth0Domain
    echo "Enter the Auth0 Client ID."
    read clientId
    echo "Enter the Auth0 Audience."
    read audience

    # DOCKER-COMPOSE
    echo "NODE_ENV=$nodeEnv
    URL=$domain" > ./.env

    # API
    echo "NODE_ENV=$nodeEnv
    PORT=3000
    CORS_ALLOWED=$domain
    MONGO_URI = mongodb://mongo:27017" > ./dbs-api/config/config.env

    echo "{ \"domain\": $auth0Domain, \"audience\": $audience }" > ./dbs-api/auth_config.json

    # ADMIN-PANEL
    echo "NODE_ENV=$nodeEnv
    VUE_APP_API_URL=$domain" > ./dbs-admin-panel/.env

    echo "{ \"domain\": $auth0Domain, \"clientId\": $clientId, \"audience\": $audience }" > ./dbs-admin-panel/auth_config.json

    # CLIENT
    echo "NODE_ENV=$nodeEnv
    VUE_APP_API_URL=$domain" > ./dbs-admin-client/.env

    echo "{ \"domain\": $auth0Domain, \"clientId\": $clientId, \"audience\": $audience }" > ./dbs-client/auth_config.json

    ufw enable
    ufw allow ssh
    ufw allow http
    ufw allow https

    cp ./config/docker-compose-dbs.service /etc/systemd/system/docker-compose-dbs.service
    systemctl enable docker-compose-dbs

    apt install nginx -y
    cp ./config/nginx.conf /etc/nginx/conf.d/default.conf

    snap install core
    snap refresh core
    snap install --classic certbot
    certbot --nginx
    nginx -s reload

    reboot
fi