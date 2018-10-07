#!/bin/bash

mv /home/appuser/puma.service /etc/systemd/system/puma.service
mv /home/appuser/puma /usr/local/bin/
systemctl daemon-reload
systemctl enable puma.service

