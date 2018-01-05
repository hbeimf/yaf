http://blog.csdn.net/xlgen157387/article/details/52672988


四、CentOS切换为iptables防火墙
切换到iptables首先应该关掉默认的firewalld，然后安装iptables服务。

1、关闭firewall：

service firewalld stop
systemctl disable firewalld.service #禁止firewall开机启动
1
2
2、安装iptables防火墙

yum install iptables-services #安装
1
3、编辑iptables防火墙配置

vi /etc/sysconfig/iptables #编辑防火墙配置文件
1
下边是一个完整的配置文件：

Firewall configuration written by system-config-firewall

Manual customization of this file is not recommended.

*filter

:INPUT ACCEPT [0:0]

:FORWARD ACCEPT [0:0]

:OUTPUT ACCEPT [0:0]

-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

-A INPUT -p icmp -j ACCEPT

-A INPUT -i lo -j ACCEPT

-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT

-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT

-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT

-A INPUT -j REJECT --reject-with icmp-host-prohibited

-A FORWARD -j REJECT --reject-with icmp-host-prohibited

COMMIT

:wq! #保存退出

service iptables start #开启
systemctl enable iptables.service #设置防火墙开机启动
1
2
个人微信公众号，欢迎扫码订阅：

