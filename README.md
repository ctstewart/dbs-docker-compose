# DBS Docker Compose

## Usage

Note: **Before running these commands, make sure you properly setup your domain.**

**This has been tested on a Digital Ocean droplet running Ubuntu 20.04.**

1. Rename "example.env" to ".env" and update with the correct values.
1. Update server_name in "./nginx/default.conf" with the correct URL.
1. Run `chmod +x ./setup.sh` in the root directory
1. Run `./setup.sh`
