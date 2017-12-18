thrift -gen php example.thrift

install thrift
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


./bootstrap.sh
./configure --libdir=/usr/lib --without-java --without-python
make 
sudo make install




