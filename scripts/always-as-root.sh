#!/usr/bin/env bash

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Restart MySQL"
service mysql restart
info "Done!"

info "Restart Redis"
service redis-server restart
info "Done!"

info "Restart Supervisor"
service supervisor restart
info "Done!"

info "Restart Apache"
service apache2 restart
info "Done!"