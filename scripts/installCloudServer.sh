#!/bin/bash

# Install Jenkins
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins

# pre-requisite packages
sudo apt-get install ia32-libs
sudo apt-get install git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.8-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-6-jre openjdk-6-jdk pngcrush schedtool libxml2 libxml2-utils xsltproc
sudo apt-get install g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev gcc-multilib clang bc

# install repo
curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > /usr/local/bin/repo
chmod a+x /usr/local/bin/repo

# install apache
# install mysql first so it's running so apache sees it.
apt-get install mysql-server
# for basic installs, unless you know why you do otherwise, use this apache
apt-get install apache2-mpm-prefork
# add php5-pgsql if you're going to run postgre
apt-get install libapache2-mod-php5 php5-mysql

# configuring jenkins proxy
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2dissite 000-default
echo '<VirtualHost *:80>' > /etc/apache2/sites-available/jenkins
echo '  ProxyPass         /  http://localhost:8080/' >> /etc/apache2/sites-available/jenkins
echo '  ProxyPassReverse  /  http://localhost:8080/' >> /etc/apache2/sites-available/jenkins
echo '  ProxyRequests     Off' >> /etc/apache2/sites-available/jenkins
echo '  # Local reverse proxy authorization override' >> /etc/apache2/sites-available/jenkins
echo '  # Most unix distribution deny proxy by default' >> /etc/apache2/sites-available/jenkins
echo '  # (ie /etc/apache2/mods-enabled/proxy.conf in Ubuntu)' >> /etc/apache2/sites-available/jenkins
echo '  <Proxy http://localhost:8080/*>' >> /etc/apache2/sites-available/jenkins
echo '    Order deny,allow' >> /etc/apache2/sites-available/jenkins
echo '    Allow from all' >> /etc/apache2/sites-available/jenkins
echo '  </Proxy>' >> /etc/apache2/sites-available/jenkins
echo '</VirtualHost>' >> /etc/apache2/sites-available/jenkins
sudo a2ensite jenkins
sudo /etc/init.d/apache2 stop
sudo /etc/init.d/apache2 start
