
https://mvnrepository.com/artifact/clojang/erlang-jinterface/1.7.1

javac -cp /web/yaf/socketio/http_server/apps/java/java_src/erlang-jinterface-1.7.1.jar JInterfaceExample.java





maven使用本地jar包
http://www.cnblogs.com/rongfengliang/p/5959456.html




/web/tar/otp_src_18.3/lib/jinterface/java_src/com/ericsson/otp/erlang'






cp /web/tar/otp_src_18.3/lib/jinterface/priv/OtpErlang.jar ./































install erlang

otpErlang.jar



http://www.sjsjw.com/kf_code/article/032953ABA020336.asp

http://www.erlang.org/doc/installation_guide/INSTALL.html#id62915


http://amornio.iteye.com/blog/1551502


Java代码  收藏代码

    # tar -zxvf otp_src_R15B01.tar.gz
    # cd otp_src_R15B01



安装依赖：
Java代码  收藏代码

    # yum install build-essential m4 openssl openssl-devel unixODBC unixODBC-devel make gcc gcc-c++ kernel-devel ncurses-devel



配置configure
Java代码  收藏代码

    # ./configure --prefix=/usr/local/erlang --enable-hipe --enable-threads --enable-smp-support --enable-kernel-poll --with-opengl --enable-debug --enable-unicode --with-javac


    make

    make install



完成之后，设置环境变量

Java代码  收藏代码

    vim /etc/profile

    ERL_HOME=/usr/local/erlang
    PATH=$ERL_HOME/bin:$PATH
    export ERL_HOME PATH



完成后保存

Java代码  收藏代码

    source /etc/profile































