#!/bin/bash

sudo apt-get install nginx
gem install bundler rails
rbenv rehash
bundle install
rbenv rehash

mkdir /vagrant/shared
mkdir /vagrant/shared/log
mkdir /vagrant/shared/pids

sudo cp setup/default /etc/nginx/sites-enabled/default
sudo cp setup/unicorn /etc/init.d/unicorn
sudo chmod 755 /etc/init.d/unicorn
sudo update-rc.d unicorn defaults
sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev
sudo npm install -g bower

sudo service unicorn start
sudo service nginx restart

rake db:create
rake db:migrate
rake setup:bootstrap
rake bower:install

