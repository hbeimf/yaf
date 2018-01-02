http://www.linuxidc.com/Linux/2016-01/127417.htm

1 下载thrift源代码
git clone https://git-wip-us.apache.org/repos/asf/thrift.git thrift
git checkout 0.9.3
2 编译并安装
安装依赖

apt-get install automake
apt-get install libssl-dev
apt-get install byacc
apt-get install bison
apt-get install flex
apt-get install libevent-dev
生成编译文件

cd thrift
./bootstrap.sh
configure.ac:84: installing './compile'
configure.ac:88: installing './config.guess'
configure.ac:88: installing './config.sub'
configure.ac:27: installing './install-sh'
configure.ac:27: installing './missing'
compiler/cpp/Makefile.am: installing './depcomp'
configure.ac: installing './ylwrap'
编译前配置,禁用java和python, 安装目录设为/usr/lib,而不是默认的/usr/local/lib

./configure --libdir=/usr/lib --without-java --without-python
...
thrift 0.9.3

Building C++ Library ......... : yes
Building C (GLib) Library .... : no
Building Java Library ........ : no
Building C# Library .......... : no
Building Python Library ...... : no
Building Ruby Library ........ : no
Building Haxe Library ........ : no
Building Haskell Library ..... : no
Building Perl Library ........ : no
Building PHP Library ......... : no
Building Erlang Library ...... : no
Building Go Library .......... : no
Building D Library ........... : no
Building NodeJS Library ...... : no
Building Lua Library ......... : no

C++ Library:
  Build TZlibTransport ...... : yes
  Build TNonblockingServer .. : yes
  Build TQTcpServer (Qt4) .... : no
  Build TQTcpServer (Qt5) .... : no

If something is missing that you think should be present,
please skim the output of configure to find the missing
component.  Details are present in config.log.
编译

make
3 运行测试程序
测试

make check
注意,v0.9.3的make check有个bug, 这里是对应的jira issue, 报错信息是

An error message from getaddrinfo on the console is expected:
Thrift: Mon Dec 14 12:19:09 2015 TServerSocket::listen() BIND 9090
4 安装
sudo make install

注意:

