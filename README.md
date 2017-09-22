# 集成了Laravel的Eloquent ORM的Yaf框架， view为bootstrap的metronic模板

![Supported PHP versions: >=5.4](https://img.shields.io/badge/PHP-%3E%3D5.4-blue.svg)
![Supported Yaf versions: >=1.8.0](https://img.shields.io/badge/Yaf-%3E%3D2.3.2-orange.svg)
![Supported Eloquent versions: 5.0](https://img.shields.io/badge/Eloquent-%205.0-green.svg)
![License](https://img.shields.io/badge/license-Apache%202-yellow.svg)

# 初始化数据库demo

```

create database system;
source {pathto}/yaf/doc/system.sql;

create database gp;
source {pathto}/yaf/doc/gp.sql;
source {pathto}/yaf/doc/m_gp_list.sql;


```

# 多个数据库链接操作如下

```
直接看控制器里写的demo

```

# 模板文件目录

```
原始模板

doc/ftpm_112_bwx 下面
或直接查看view里的demo

```

# Nginx

```
nginx.conf 
add 

include ./vhost/*.conf;

参照
doc/yaf.demo.com.conf


```


# 文件上传

```
// 上传目录
$savePath = getConfig('upload', 'path');

// 允许的规则
$allowType = getConfig('upload', 'rule');

$result = parent::upload($allowType, $savePath);
```

# 邮件发送

```

# 首先安装sendmail模块
yum -y install sendmail
/etc/rc.d/init.d/sendmail start

// 发送邮件，可群发
sendmail([molaifeng@foxmail.com], '测试邮件', '这是一封测试邮件');
```

# 数据加解密

```

$string = '数据加解密';
$crypt = new Util_CryptAES();
$crypt->set_key(getConfig('CryptAES', 'key'));
$crypt->require_pkcs5();

// 加密
$crypt_string = $crypt->encrypt($string);

// 解密
$decrypt_string = $crypt->decrypt($crypt_string);

echo $crypt_string . ' ' . $decrypt_string; // 1MxgJsgKZKXXhTE8msOKpA== 数据加解密

// 此类还可以配合Java来进行加解密，具体链接可参考 http://www.cnblogs.com/yipu/articles/3871576.html
```

# 日志记录

```

// 直接记录在以日期开头的文件里，如16_08_24.log
Log_Log::info('this is a log', true, true);

// 加上前缀，prefix_16_08_24.log
Log_Log::info('this is a log', true, true, 'prefix');
```

# Curl 操作

```

$curl = new \Http\Curl();

// get
$curl->get('https://www.example.com/search', array(
    'q' => 'keyword',
));

// post
$curl->post('https://www.example.com/login/', array(
    'username' => 'myusername',
    'password' => 'mypassword',
));

// more https://github.com/php-curl-class/php-curl-class
```

# 全局异常捕获

```

try {
    if ($_POST['test']) {

    }
} catch (Exception $e) {
    echo $e->getMessage(); // Undefined index: test
}


```



改造来源

https://github.com/molaifeng/yaf_eloquent

各种开发环境的版本

http://yaf.demo.com/info.php

PHP Version 5.6.9
yaf-2.3.4

swoole 1.8.5

golang, erlang 版本都是 1.8.3

maomao@maomao-ThinkCentre-E73:/web/yaf$ java -version
java version "1.8.0_131"
Java(TM) SE Runtime Environment (build 1.8.0_131-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.131-b11, mixed mode)




    Configure Command
        './configure' '--prefix=/usr/local/php' '--with-config-file-path=/usr/local/php/etc'
        '--with-config-file-scan-dir=/usr/local/php/etc/php.d' '--enable-fpm' '--with-mysql=mysqlnd'
        '--with-mysqli=mysqlnd' '--with-pdo-mysql=mysqlnd' '--with-iconv-dir' '--with-freetype-dir'
        '--with-jpeg-dir' '--with-png-dir' '--with-zlib' '--with-libxml-dir=/usr' '--enable-xml' '--disable-rpath'
        '--enable-bcmath' '--enable-shmop' '--enable-inline-optimization' '--with-curl' '--enable-mbregex'
        '--enable-mbstring' '--with-mcrypt' '--enable-ftp' '--with-gd' '--enable-gd-native-ttf' '--with-openssl'
        '--with-mhash' '--enable-pcntl' '--enable-sockets' '--with-xmlrpc' '--enable-zip' '--enable-soap' '--without-pear'
        '--with-gettext' '--disable-fileinfo' '--enable-opcache=no' '--enable-sysvsem' '--enable-sysvshm' '--enable-sysvmsg'





安装yaf扩展

/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
#完成安装


/usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/

sudo vim /usr/local/php/etc/php.ini

大概是这个行数

 734 extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/"
 735 extension=memcache.so
 736 extension=phalcon.so
 737 extension=yaml.so
 738 extension=redis.so
 739 extension=amqp.so
 740 extension=swoole.so
 741 extension=zookeeper.so
 742 extension=yaf.so

重启php网关
sudo /etc/init.d/php-fpm restart

安装完成


http://yaf.demo.com/









