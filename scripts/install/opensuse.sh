#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8

# zypper refresh


# systemctl stop SuSEfirewall2

# for debug
zypper install -y htop
# for debug end

zypper install -y openssl openssl-devel
zypper install -y bison re2c make cmake gcc 
zypper install -y autoconf
zypper install -y python3-pip
zypper install -y pcre pcre-devel
zypper install -y graphviz libxml2 libxml2-devel
zypper install -y curl curl-devel
zypper install -y freetype freetype-devel
zypper install -y mysql-devel

zypper install -y ImageMagick ImageMagick-devel

cd /www/server/mdserver-web/scripts && bash lib.sh
chmod 755 /www/server/mdserver-web/data


cd /www/server/mdserver-web && ./cli.sh start
isStart=`ps -ef|grep 'gunicorn -c setting.py app:app' |grep -v grep|awk '{print $2}'`
n=0
while [[ ! -f /etc/init.d/mw ]];
do
    echo -e ".\c"
    sleep 1
    let n+=1
    if [ $n -gt 20 ];then
    	echo -e "start mw fail"
        exit 1
    fi
done

cd /www/server/mdserver-web && /etc/init.d/mw stop
cd /www/server/mdserver-web && /etc/init.d/mw start
cd /www/server/mdserver-web && /etc/init.d/mw default

