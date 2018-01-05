https://www.cnblogs.com/the-study-of-linux/p/5217599.html

[mysqld]
datadir=/usr/local/mysql/data
socket=/tmp/mysql.sock

[mysql]
socket=/tmp/mysql.sock
[mysql.server]
user=mysql
basedir=/usr/local/mysql

[safe_mysqld]
err-log=/usr/local/mysql/mysqld.log
pid-file=/usr/local/mysql/mysqld.pid


