#!/bin/bash

function usage
{
	echo "usage: `basename $0` {-u db user} {-p db password} {-d wp database} {-l wp directory} {-n site name}"
	echo "    -u = WordPress MySql user"
	echo "    -p = WordPress MySql password"
	echo "    -d = WordPress MySql database"
	echo "    -l = WordPress directory"
	echo "    -n = site name"
} 

while getopts "fu:p:d:l:n:" opt; do
	case $opt in
		u)
			db_user=$OPTARG
			;;
		p)
			db_password=$OPTARG
			;;
		d)
			wp_db=$OPTARG
			;;
		l)
			wp_dir=$OPTARG
			;;
		n)
			site_name=$OPTARG
			;;
		*)
			usage
			exit
			;;
	esac
done

if [ "${db_user}" == "" ]; then
	echo "WordPress user cannot be empty"
	usage
	exit
fi

if [ "${db_password}" == "" ]; then
	echo "WordPress password cannot be empty"
	usage
	exit
fi

if [ "${wp_db}" == "" ]; then
	echo "WordPress database cannot be empty"
	usage
	exit
fi

if [ "${wp_dir}" == "" ]; then
	echo "WordPress directory cannot be empty"
	usage
	exit
fi

if [ "${site_name}" == "" ]; then
	echo "site name cannot be empty"
	usage
	exit
fi

echo "wp user: ${db_user}"
echo "wp password: ${db_password}"
echo "wp db: ${wp_db}"
echo "wp directory: ${wp_dir}"
echo "wp full install: ${full}"

#yum -y install httpd mariadb-server mariadb php php-mysql php-gd wget rsync git

#systemctl start httpd.service
#systemctl start mariadb
#systemctl enable httpd.service
#systemctl enable mariadb

if test -d ${wp_dir}; then
	echo "WordPress directory ${wp_dir} already exists. Cannot continue"
	exit
fi

cd /tmp
wget http://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz
cd wordpress
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$wp_db/g" wp-config.php
sed -i "s/username_here/$db_user/g" wp-config.php
sed -i "s/password_here/$db_password/g" wp-config.php

echo "*******************************************************"
echo "run the following commands as root:"
echo "rsync -avP /tmp/wordpress/ ${wp_dir}"
echo "mkdir ${wp_dir}/wp-content/uploads"
echo "chown -R apache:apache ${wp_dir}"
echo "chcon -t httpd_sys_rw_content_t ${wp_dir} -R"

#mysql_secure_installation
echo "*******************************************************"
echo "run the following commands as root in mysql:"
#echo "mysql -u root -e \"CREATE DATABASE $wp_db;\""
echo "CREATE DATABASE $wp_db;"
echo "CREATE USER $db_user@localhost IDENTIFIED BY '$db_password';"
echo "GRANT ALL PRIVILEGES ON $wp_db.* TO $db_user@localhost;"
echo "FLUSH PRIVILEGES;"
#systemctl restart httpd.service

echo "*******************************************************"
echo "put the following content in /etc/httpd/conf.d/vhost.conf"
echo "<VirtualHost *:80>"
echo "   ServerAdmin root@localhost"
echo "   ServerName ${site_name}"
echo "   ServerAlias www.${site_name}"
echo "   DocumentRoot ${wp_dir}"
echo "   <Directory \"${wp_dir}\">"
echo "      Options Indexes FollowSymLinks"
echo "      AllowOverride all"
echo "      Require all granted"
echo "   </Directory>"
echo "   ErrorLog /var/log/httpd/${site_name}-error.log"
echo "   CustomLog /var/log/httpd/${site_name}-access.log common"
echo "</VirtualHost>"

echo "<VirtualHost *:443>"
echo "   ServerAdmin root@localhost"
echo "   ServerName ${site_name}"
echo "   ServerAlias www.${site_name}"
echo "   DocumentRoot ${wp_dir}"
echo "   <Directory \"${wp_dir}\">"
echo "      Options Indexes FollowSymLinks"
echo "      AllowOverride all"
echo "      Require all granted"
echo "   </Directory>"
echo "   ErrorLog /var/log/httpd/${site_name}-error.log"
echo "   CustomLog /var/log/httpd/${site_name}-access.log common"
echo "</VirtualHost>"
