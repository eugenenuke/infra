#!/bin/bash
set -e

source ~/.profile
git clone https://github.com/Artemmkin/reddit.git
cd reddit
bundle install

sudo mv /tmp/puma.service /etc/systemd/system/puma.service
touch /home/appuser/db_config

sudo systemctl start puma
sudo systemctl enable puma
