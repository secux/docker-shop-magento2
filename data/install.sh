#!/bin/sh

echo "Running install.sh for $1"

# TODO: Download selected version via  (from docker-sho-manager) from githup.com/magento/magento2 and run installer

echo "Cloning magento repo"
# add version
git clone https://github.com/magento/magento2.git /www

echo "Installing composer packages"
cd /www && composer.phar install --ignore-platform-reqs