#!/bin/bash

echo "--------------------------"
echo "Update packages"
sudo apt-get update
sudo apt-get -y upgrade

printf "
 --------------------------
|    Start installation    |
 --------------------------
"
echo "make"
sudo apt-get -y install make

echo "--------------------------"
echo "tree"
sudo add-apt-repository universe
sudo apt-get -y install tree

echo "--------------------------"
echo "PHP 7.2"
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get -y update
sudo apt-get install -y php7.2 php7.2-fpm php7.2-xsl php7.2-mbstring php7.2-curl php7.2-pgsql php-xdebug php-imagick

echo "--------------------------"
echo "Composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

echo "--------------------------"
echo "Curl"
sudo apt-get -y install curl

echo "--------------------------"
echo "Node.js"
# альтернативные способы установки:
# https://github.com/nodesource/distributions
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get -y install nodejs

echo "--------------------------"
echo "Nginx"
sudo apt-get -y install nginx
sudo cp -f /vagrant/preset/nginx /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/nginx /etc/nginx/sites-enabled/
sudo nginx -s reload

echo "--------------------------"
echo "XDebug"
sudo cp -f /vagrant/preset/20-xdebug.ini /etc/php/7.2/cli/conf.d/
sudo cp -f /vagrant/preset/20-xdebug.ini /etc/php/7.2/fpm/conf.d/
sudo service php7.2-fpm restart

echo "--------------------------"
echo "Makefile for magic"
ln -s /vagrant/preset/Makefile /home/vagrant/

printf "
 --------------------------
|  Installation complete!  |
 --------------------------

1. Run:
  vagrant ssh
  make initial_setting
  make postgres_install
2. Open 192.168.33.10 in your browser.
3. Configure your PhpStorm:
  XDebug:
    1. (File - Settings - Languages - PHP - Debug) 9000 port and DBGp proxy for 192.168.33.10
    2. (Run - Edit configuration) ip your LOCAL machine and filemap
  PostgreSQL:
    ('Database' on workspace - Data Source: PostgreSQL):
      host: 192.168.33.10; 
      port: 5234;
      database: postgres;
      user: developer;
      password: developer;
      Driver: PostgreSQL (click 'Install missing driver' if this first time).

Have questions? make info
--------------------------
Have a nice day! :3"
