
===== install nginx ==========================================

sudo /usr/local/nginx/sbin/nginx
sudo /usr/local/nginx/sbin/nginx -s stop
sudo /usr/local/nginx/sbin/nginx -s reload


include vhost/*.conf;


===== install php =======================================

sudo service php-fpm start
sudo service php-fpm restart


netstat -lnp | grep 9000
netstat -tnlup | grep 9000

/usr/local/php/bin/phpize 
./configure --with-php-config=/usr/local/php/bin/php-config 
make && make install 

/usr/local/php5.6.9/lib/php/extensions/no-debug-non-zts-20131226/





===== install mysql ==================================
http://blog.csdn.net/suitingwei/article/details/50315809


sudo /usr/local/mysql/bin/mysqld_safe &

mysql -uroot -h127.0.0.1 -p


mysql -uroot -h127.0.0.1 -p123456



mysql -uroot  
mysql> SET PASSWORD = PASSWORD('123456');



sudo ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock

sudo ln –s /var/lib/mysql/mysql.sock /var/lib/mysql/


sudo cp /web/yaf/doc/composer.phar /usr/local/bin/composer


mysql -uroot -p123456 -h192.168.241.129



======== git server ==============================================


git init --bare proxy_server.git
chown -R git:git proxy_server.git

git clone git@127.0.0.1:/git/proxy_server.git
git clone git@192.168.241.129:/git/proxy_server.git


git push origin master


git init --bare hub_server.git
chown -R git:git hub_server.git

git clone git@127.0.0.1:/git/hub_server.git
git clone git@192.168.241.129:/git/hub_server.git




sudo ufw disable

==============install golang =====================================

export GOROOT=/usr/local/go  #设置为go安装的路径
export GOPATH=/web/gocode   #默认安装包的路径
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin




============ install rust ==========================================
curl -sf -L https://static.rust-lang.org/rustup.sh | sh


rustc --version



