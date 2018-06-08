#!/bin/sh

echo "Running install.sh for $1 using $2 as server name"

mkdir -p /root/.composer
cat << EOF > /root/.composer/auth.json
{
    "http-basic": {
        "repo.magento.com": {
            "username": "4b038199040d04ad1bcf5077f8aa2a3d",
            "password": "01e681c7a142ad64d065d44cdbf07c4a"
        }
    }
}
EOF

echo "Copy magento repo"
cd /www
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=$1 /www

mkdir -p /www/var/composer_home
cat << EOF > /www/var/composer_home/auth.json
{
    "http-basic": {
        "repo.magento.com": {
            "username": "4b038199040d04ad1bcf5077f8aa2a3d",
            "password": "01e681c7a142ad64d065d44cdbf07c4a"
        }
    }
}
EOF

echo "Setting filesystem permissions"
cd /www
find var generated vendor pub/static pub/media app/etc -type f -exec chmod u+w {} \;
find var vendor generated pub/static pub/media app/etc -type d -exec chmod u+w {} \;
chmod u+x bin/magento

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

php bin/magento sampledata:deploy
php bin/magento setup:install --admin-firstname="Ad" --admin-lastname="Minator" --admin-email="adminator@adminator.ro" --admin-user="Adminator" --admin-password="sdr117781" --base-url="http://$2:6090/" --backend-frontname="admin" --db-host="database" --db-name="secu" --db-user="secu" --db-password="secu"

php bin/magento admin:user:unlock Adminator

# php -r "phpinfo();"
# php -m

#echo "Installing Magento 2 static files"
#php bin/magento setup:static-content:deploy

echo "Setting filesystem permissions"
chown -R www-data /www
chgrp -R www-data /www

echo "Installation completed"
