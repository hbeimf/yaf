https://www.cnblogs.com/gabin/p/6385908.html
https://www.cnblogs.com/weifeng1463/p/7714492.html

1. 安装配置依赖项 

如想使用Postfix来发送邮件,在安装期间请选择'Internet Site'. 您也可以用sendmai或者 配置SMTP服务 并 使用SMTP发送邮件.

在 Centos 6 和 7 系统上, 下面的命令将在系统防火墙里面开放HTTP和SSH端口. 

sudo apt-get install curl openssh-server ca-certificates postfix
2. 添加GitLab仓库,并安装到服务器上 

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
sudo apt-get install gitlab-ee
如果你不习惯使用命令管道的安装方式, 你可以在这里下载 安装脚本 或者 手动下载您使用的系统相应的安装包(RPM/Deb) 然后安装 

dpkg -i gitlab-ee-XXX.deb
3. 启动GitLab 

sudo gitlab-ctl reconfigure
4. 使用浏览器访问GitLab 

首次访问GitLab,系统会让你重新设置管理员的密码,设置成功后会返回登录界面.

默认的管理员账号是root,如果你想更改默认管理员账号,请输入上面设置的新密码登录系统后修改帐号名.



GitLab常用命令
sudo gitlab-ctl start    # 启动所有 gitlab 组件；
sudo gitlab-ctl stop        # 停止所有 gitlab 组件；
sudo gitlab-ctl restart        # 重启所有 gitlab 组件；
sudo gitlab-ctl status        # 查看服务状态；
sudo gitlab-ctl reconfigure        # 启动服务；
sudo vim /etc/gitlab/gitlab.rb        # 修改默认的配置文件；
gitlab-rake gitlab:check SANITIZE=true --trace    # 检查gitlab；
sudo gitlab-ctl tail        # 查看日志；


===================================================================
centos7下gitlab的配置（nginx冲突、端口更改）
https://blog.csdn.net/donglynn/article/details/74002540

yum install gitlab-ce


sudo vim /etc/gitlab/gitlab.rb
nginx['listen_port'] = 82 #默认值即80端口 nginx['listen_port'] = nil


sudo vim /var/opt/gitlab/nginx/conf/gitlab-http.conf
listen *:82; #默认值listen *:80


===================================
https://www.gitlab.com.cn/installation/#centos-7


sudo yum install -y curl policycoreutils-python openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld



sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix


curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash


sudo EXTERNAL_URL="http://gitlab.example.com" yum install -y gitlab-ee





