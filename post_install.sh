#!/bin/sh

echo "Installing Organizr"
echo 'listen = /var/run/php-fpm.sock' >> /usr/local/etc/php-fpm.conf
echo 'listen.owner = www' >> /usr/local/etc/php-fpm.conf
echo 'listen.group = www' >> /usr/local/etc/php-fpm.conf
echo 'listen.mode = 0660' >> /usr/local/etc/php-fpm.conf
cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini
sed -i '' -e 's?;date.timezone =?date.timezone = "Universal"?g' /usr/local/etc/php.ini
sed -i '' -e 's?;cgi.fix_pathinfo=1?cgi.fix_pathinfo=0?g' /usr/local/etc/php.ini

git clone -b v2-develop https://github.com/causefx/Organizr /usr/local/www/Organizr

chown -R www:www /usr/local/www


sysrc php_fpm_enable=YES
sysrc nginx_enable=YES

service php-fpm start
service nginx start
