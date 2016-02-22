#!/bin/sh

echo "Running install.sh for $1"

# TODO: Download selected version via  (from docker-sho-manager) from githup.com/magento/magento2 and run installer

echo "Cloning magento repo"
git clone --branch $1 --depth 1 https://$2:x-oauth-basic@github.com/magento/magento2.git /www

echo "Installing composer packages"
cd /www && composer.phar self-update && composer.phar config --global github-oauth.github.com $2 && composer.phar update --ignore-platform-reqs

echo "Setting filesystem permissions"
chown -R www-data /www
chgrp -R www-data /www

echo "Installation completed"