https://www.cnblogs.com/langtianya/p/5187681.html


方式一:
下载地址：http://redis.io/download，下载最新文档版本。

本教程使用的最新文档版本为 2.8.17，下载并安装：

$ wget http://download.redis.io/releases/redis-2.8.17.tar.gz
$ tar xzf redis-2.8.17.tar.gz
$ cd redis-2.8.17
$ make
make完后 redis-2.8.17目录下会出现编译后的redis服务程序redis-server,还有用于测试的客户端程序redis-cli,两个程序位于安装目录 src 目录下：

下面启动redis服务.

$ cd src
$ ./redis-server
注意这种方式启动redis 使用的是默认配置。也可以通过启动参数告诉redis使用指定配置文件使用下面命令启动。

$ cd src
$ ./redis-server redis.conf
redis.conf是一个默认的配置文件。我们可以根据需要使用自己的配置文件。

启动redis服务进程后，就可以使用测试客户端程序redis-cli和redis服务交互了。 比如：

$ cd src
$ ./redis-cli
redis> set foo bar
OK
redis> get foo
"bar"



======================================================================

http://www.runoob.com/docker/docker-install-redis.html


$ docker pull  redis:3.2

$ mkdir -p /redis /redis/data

$ docker run -p 6379:6379 -v /redis/data:/data  -d redis:3.2 redis-server --appendonly yes


# docker exec -it 8f94ca4b0631 redis-cli


