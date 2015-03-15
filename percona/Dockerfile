FROM phusion/baseimage:latest
MAINTAINER Martin Fenner <mfenner@plos.org>

ENV DB_VERSION 5.6
ENV DB_BIND_ADDRESS 0.0.0.0
ENV DB_ROOT_PASSWORD EZ$zspyxF2
ENV DB_PORT 3306
ENV DEBIAN_FRONTEND noninteractive

CMD ["/sbin/my_init"]

# Allow stop|start of mysql service
# Pin percona packages so that they are preferred over default packages (percona-xtrabackup)
RUN \
  echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d && \
  echo "Package: *\nPin: release o=Percona Development Team\nPin-Priority: 1001" > /etc/apt/preferences.d/00percona.pref

# Install Percona server, client, and xtrabackup. Cleanup after installation
# Follow instructions from http://www.percona.com/doc/percona-server/5.6/installation/apt_repo.html
RUN \
  apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
  echo "deb http://repo.percona.com/apt $(lsb_release -cs) main" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y percona-server-server-$DB_VERSION percona-server-client-$DB_VERSION && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && rm /usr/sbin/policy-rc.d

# Install runit service
RUN mkdir /etc/service/mysql
COPY runit/mysql.sh /etc/service/mysql/run
RUN chmod +x /etc/service/mysql/run

# Configure MySQL
RUN \
  echo "[mysqld]"                          >>/etc/mysql/my.cnf && \
  echo "bind-address = $DB_BIND_ADDRESS"   >>/etc/mysql/my.cnf && \
  echo "skip-name-resolve"                 >>/etc/mysql/my.cnf && \
  echo "character-set-server = utf8"       >>/etc/mysql/my.cnf && \
  echo "init-connect = 'SET NAMES utf8'"   >>/etc/mysql/my.cnf

# Delete anonymous users and test table, secure root account
# RUN \
#   mysqld_safe --user=mysql & \
#   /usr/bin/mysqladmin --silent --wait=30 ping || exit 1 && \
#   mysql -e "DELETE FROM mysql.user WHERE User = '';" && \
#   mysql -e "DROP DATABASE test;" && \
#   mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" && \
#   mysql -e "UPDATE mysql.user SET Password = PASSWORD(\"${DB_ROOT_PASSWORD}\") WHERE User = 'root';" && \
#   mysql -e "FLUSH PRIVILEGES;" && \
#   echo "Anonymous mysql user account deleted and test db dropped." && \
#   echo "mysql root password set to ENV[MYSQL_ROOT_PASSWORD]"

# Define mountable directories
VOLUME "/var/lib/mysql"

EXPOSE  3306
