#!/usr/bin/env bash

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Install composer"

if [ ! -f "/usr/local/bin/composer" ];
then
	cp -rf /vagrant/composer.phar /usr/local/bin/composer && \
	chmod +x /usr/local/bin/composer
fi

info "Done!"