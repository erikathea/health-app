#!/bin/bash

sudo apt-get install nginx
gem install bundler rails
rbenv rehash
bundle install
rbenv rehash

sudo cp set/default /etc/nginx/sites-enabled/default
sudo cp setup/unicorn /etc/init.d/unicorn
sudo chmod 755 /etc/init.d/unicorn
sudo update-rc.d unicorn defaults

sudo service unicorn start
sudo service nginx restart

rake db:create
rake db:migrate
rake setup:bootstrap

