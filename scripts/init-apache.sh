#!/usr/bin/env bash

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

sites_default_path="/etc/apache2/sites-default/"

info "Init Apache"

if [ ! -d ${sites_default_path} ];
then
	mkdir -p ${sites_default_path}
	echo -e "
IncludeOptional sites-default/*.conf
" >> /etc/apache2/apache2.conf
fi

block="<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/localhost.error.log
    CustomLog \${APACHE_LOG_DIR}/localhost.access.log combined
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
"

echo "$block" > "${sites_default_path}/default.conf"

rm -f /etc/apache2/sites-available/*
rm -f /etc/apache2/sites-enabled/*

info "Done!"