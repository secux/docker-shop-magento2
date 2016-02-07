#!/bin/sh

echo "Running install.sh for $1"

# TODO: Download selected version via  (from docker-sho-manager) from githup.com/magento/magento2 and run installer

echo "Cloning magento repo"
# add version
git clone https://2245dfb67d208f3503081b38814bdd54e04368f7:x-oauth-basic@github.com/magento/magento2.git /www

echo "Installing composer packages"
cd /www && composer.phar self-update && composer.phar config -g github-oauth.github.com 2245dfb67d208f3503081b38814bdd54e04368f7 && composer.phar install --ignore-platform-reqs