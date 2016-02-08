#!/bin/sh

echo "Running install.sh for $1"

# TODO: Download selected version via  (from docker-sho-manager) from githup.com/magento/magento2 and run installer

echo "Cloning magento repo"
git clone https://2245dfb67d208f3503081b38814bdd54e04368f7:x-oauth-basic@github.com/magento/magento2.git /www

echo "Installing composer packages"
cd /www && composer.phar self-update && composer.phar config -g github-oauth.github.com 2245dfb67d208f3503081b38814bdd54e04368f7 && composer.phar install --ignore-platform-reqs

echo "Setting filesystem permissions"
chown -R www-data /www
chgrp -R www-data /www

echo "Checking out $1"
checkOutCommand="git checkout $1"
eval $checkOutCommand
echo "Installation completed"