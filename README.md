# DBS Docker Compose

## Download

Note: **This has been tested on a Digital Ocean droplet running Ubuntu 20.04.**

`git clone --recurse-submodules https://github.com/heelercs/dbs-docker-compose.git dbs`

## Usage

### Init images and container

1. CD into the dbs directory `cd dbs`
1. Run `apt install docker-compose`
1. Rename "example.env" to ".env" and update URL with "https://YOURDOMAIN".
1. Run `docker-compose up` to make sure everything starts without error.
1. Ctl-C to stop the process.
1. Run `docker-compose down`

### Setup nginx and docker-compose service

Note: **Before running these commands, make sure you properly setup your domain.**

1. Update server_name and YOURDOMAIN ssl cert route in "./config/nginx.conf" with your domain.
1. Run `chmod +x ./setup.sh` in the root directory
1. Run `./setup.sh`
