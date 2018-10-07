#!/bin/bash

cd
source ~/.rvm/scripts/rvm
git clone https://github.com/Artemmkin/reddit.git
cd reddit && bundle install
puma -d
