# change dns
# vi /etc/resolv.conf
# change nameserver value to 8.8.8.8


#### install node and npm
#arm71
cd /data
wget https://npm.taobao.org/mirrors/node/v14.16.1/node-v14.16.1-linux-armv7l.tar.xz
tar -xvf node-v14.16.1-linux-armv7l.tar.xz
ln -s node-v14.16.1-linux-armv7l node

#mv node-v14.16.1-linux-armv7l node-v14.16.1


#x64
#wget https://npm.taobao.org/mirrors/node/v14.16.1/node-v14.16.1-linux-x64.tar.xz
#tar -xvf node-v14.16.1-linux-x64.tar.xz
#ln -s node-v14.16.1-linux-x64 node

# install mDNS dependency
sudo apt-get install avahi-daemon libavahi-compat-libdnssd-dev




#vi /etc/resolv.conf  加入 192.168.9.35
#在/etc/environment 加入 :/data/node/bin
vi /etc/environment 加入 :/data/node/bin
echo  "export PATH=\$PATH:/data/node/bin" >> /etc/profile

#### config
# set PATH
# set npm use root
# set npm use taobao mirror

export PATH=$PATH:/data/node/bin
npm config -g set unsafe-perm=true
npm config set registry https://registry.npm.taobao.org







#### install mqtt-server

#git clone ssh://761208@gerrit.sdp.nd:29418/app-cpp/local-iot mqtt-server -b mqtt-server
cd /data
git clone http://761208@gerrit.sdp.nd/a/app-cpp/local-iot mqtt-server -b mqtt-server

#git clone http://github.com/czq7966/cmd-gateway mqtt-server -b mqtt-server


cd /data/mqtt-server
npm install


#### install cmd gateway
cd /data
#ssh download
#git clone ssh://761208@gerrit.sdp.nd:29418/app-cpp/local-iot cmd-gateway -b cmd-gateway

#http download
git clone http://761208@gerrit.sdp.nd/a/app-cpp/local-iot cmd-gateway -b cmd-gateway
#git clone http://github.com/czq7966/cmd-gateway cmd-gateway -b cmd-gateway


 
cd /data/cmd-gateway
npm install
cd /data/cmd-gateway/data
npm install

#cd /data/cmd-gateway
#npm start


# auto start
# see https://blog.csdn.net/sayyy/article/details/79276575
cd /data/cmd-gateway
cp cmd-gateway.service /lib/systemd/system/cmd-gateway.service
systemctl enable cmd-gateway
systemctl list-unit-files|grep cmd-gateway

cp mqtt-server.service /lib/systemd/system/mqtt-server.service 
systemctl enable mqtt-server
systemctl list-unit-files|grep mqtt-server
