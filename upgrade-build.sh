#!/bin/bash

function upgradingPhp {
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt-get update -y
    sudo apt-get install libapache2-mod-php7.0 -y
    sudo a2dismod php5
    sudo a2enmod php7.0
    sudo apt-get install php7.0-gd -y
    sudo apt-get install php7.0-dom -y
    sudo apt-get install php7.0-mbstring -y
    sudo apt-get install php7.0-zip -y
    sudo apt-get install php7.0-curl -y
    sudo apt-get install php7.0-mysql -y
    sudo apt-get install php7.0-sqlite -y
    
}
upgradingPhp

function upgradingNPM {
    sudo npm i npm -g
}
upgradingNPM

function upgradingMySQL {
    mysql-ctl start
    wget http://dev.mysql.com/get/mysql-apt-config_0.7.3-1_all.deb
    sudo dpkg -i mysql-apt-config_0.7.3-1_all.deb
    sudo apt-get update
    sudo apt-get install mysql-server -y --force-yes
    rm mysql-apt-config_0.7.3-1_all.deb
}
upgradingMySQL

function craftProject {
    rm README.md php.ini hello-world.php
    sudo composer global require 'laravel/installer'
    export PATH=~/.composer/vendor/bin:$PATH
}
craftProject

function editFile {
    sudo sh -c 'echo "<VirtualHost *:8080>
    DocumentRoot /home/ubuntu/workspace/public
    ServerName https://\${C9_HOSTNAME}:443
    LogLevel info
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
    <Directory /home/ubuntu/workspace>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
ServerName https://\${C9_HOSTNAME}
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet" > /etc/apache2/sites-enabled/001-cloud9.conf'
}
editFile

rm -- "$0"
