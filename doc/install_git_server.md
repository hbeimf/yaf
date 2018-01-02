https://my.oschina.net/yushulx/blog/609779

sudo apt-get install openssh-server


sudo useradd git
sudo passwd git
sudo addgroup git

sudo mkdir /git
sudo chmod 777 /git -R



sudo git init --bare test123.git
sudo chown -R git:git test123.git
git clone git@127.0.0.1:/git/test123.git



sudo git init --bare m.demo.com.git
sudo chown -R git:git m.demo.com.git
git clone git@127.0.0.1:/git/m.demo.com.git

sudo git init --bare hub_server.git
sudo chown -R git:git hub_server.git
git clone git@127.0.0.1:/git/hub_server.git

sudo git init --bare proxy_server.git
sudo chown -R git:git proxy_server.git
git clone git@127.0.0.1:/git/proxy_server.git










