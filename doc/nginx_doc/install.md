https://www.centos.bz/2011/07/centos-compile-nginx-from-source/
http://www.cnblogs.com/blacksword/archive/2013/03/29/2989498.html


CentOS源码编译安装Nginx
作者:朱 茂海 /分类:Nginx 
字号：L M S

安装编译用到的软件：
************************************************************************************************
    yum install glib2-devel openssl-devel pcre-devel bzip2-devel gzip-devel
	yum install perl perl-devel perl-ExtUtils-Embed
	yum install gcc
__________________________________________________________________________________________________	
	
		
******************************************************************************		
		./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-stream
		make
		make install
		/usr/local/nginx/sbin/nginx
		/usr/local/nginx/sbin/nginx -s stop
		/usr/local/nginx/sbin/nginx -s reload
_____________________________________________________________________________	
	
	
groupadd www
useradd -s /sbin/nologin -M -g www www
	
	
	
	

更多的编译选项请参考：http://wiki.nginx.org/NginxInstallOptions
为Nginx建立用户

    /usr/sbin/useradd -c "Nginx user" -s /bin/false -r -d /var/lib/nginx nginx

运行Nginx

    /usr/sbin/nginx

配置文件在：

    /etc/nginx/nginx.conf

    echo "NGINX_CONF_FILE=/etc/nginx/nginx.conf" > /etc/sysconfig/nginx