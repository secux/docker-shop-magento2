#!/bin/sh

echo "Running install.sh for $1 using $2 as server name"

echo "Cloning magento repo"
git clone --branch $1 --depth 1 https://github.com/magento/magento2.git /www

echo "Installing composer packages"
cd  /www \
    && composer.phar self-update \
    && composer.phar install --ignore-platform-reqs

echo "Automatically installing your Magento 2 shop with the following params: \n 
--admin-firstname=Ad
--admin-lastname=Minator
--admin-email=adminator@adminator.ro
--admin-user=Adminator
--admin-password=sdr117781
--base-url=http://$2:6090/
--backend-frontname=admin
--db-host=database
--db-name=secu
--db-user=secu
--db-password=secu"

php bin/magento setup:install --admin-firstname="Ad" --admin-lastname="Minator" --admin-email="adminator@adminator.ro" --admin-user="Adminator" --admin-password="sdr117781" --base-url="http://$2:6090/" --backend-frontname="admin" --db-host="database" --db-name="secu" --db-user="secu" --db-password="secu"

php bin/magento admin:user:unlock Adminator

# php -r "phpinfo();"
# php -m

echo "Installing Magento 2 static files"
php bin/magento setup:static-content:deploy

echo "Setting filesystem permissions"
chown -R www-data /www
chgrp -R www-data /www

chmod -R 777 /www/generated
chmod -R 777 /www/pub/static
chmod -R 777 /www/pub/media
chmod -R 777 /www/var
chmod -R 777 /www/app/etc

echo "Installation completed"
