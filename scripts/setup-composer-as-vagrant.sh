#!/usr/bin/env bash

#== Import script args ==

github_token=$(echo "$1")

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Setup composer"

# 配置使用国内代理源
composer config -g repo.packagist composer https://packagist.phpcomposer.com

# 配置 GitHub Token
composer config --global github-oauth.github.com ${github_token}

# Install plugins for composer
composer global require "fxp/composer-asset-plugin:^1.2.0" --no-progress

info "Done!";