#! /bin/bash

sudo mount -t vboxsf shared  /mnt/shared

sudo /usr/local/nginx/sbin/nginx
sudo service php-fpm start
sudo /usr/local/mysql/bin/mysqld_safe &
/install/redis-2.8.17/src/redis-server & 


# 开启代理 
 # /usr/bin/lantern