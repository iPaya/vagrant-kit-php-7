#!/usr/bin/env bash

#== Import script args ==

server_name=$(echo "$1")
document_root=$(echo "$2")

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Configure Apache VirtualHost of \"$server_name\""

block="<VirtualHost *:80>
    ServerName $server_name
    DocumentRoot $document_root

    <Directory $document_root>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/$server_name.error.log
    CustomLog \${APACHE_LOG_DIR}/$server_name.access.log combined
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
"

echo "$block" > "/etc/apache2/sites-available/$server_name.conf"
ln -fs "/etc/apache2/sites-available/$server_name.conf" "/etc/apache2/sites-enabled/$server_name.conf"

info "Done!";