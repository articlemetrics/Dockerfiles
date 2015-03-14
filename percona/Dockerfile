FROM phusion/baseimage:latest
MAINTAINER Martin Fenner <mfenner@plos.org>

# add user and group
RUN groupadd -r mysql && useradd -r -g mysql mysql

ENV DB_VERSION 5.6
ENV DB_BIND_ADDRESS 0.0.0.0
ENV DB_ROOT_PASSWORD EZ$zspyxF2
ENV DB_PORT 3306
ENV DEBIAN_FRONTEND noninteractive

# Allow stop|start of mysql service
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d

# Pin Percona packages so that they are preferred over default packages
RUN echo "Package: *\nPin: release o=Percona Development Team\nPin-Priority: 1001" > /etc/apt/preferences.d/00percona.pref

# Install Percona Server
# Follow instructions from http://www.percona.com/doc/percona-server/5.6/installation/apt_repo.html
RUN \
  apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
  echo "deb http://repo.percona.com/apt trusty main" >> /etc/apt/sources.list && \
  echo "deb-src http://repo.percona.com/apt trusty main" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y percona-server-server-"${DB_VERSION}" percona-server-client-"${DB_VERSION}"

# Cleanup after installation
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && rm /usr/sbin/policy-rc.d

# Configure MySQL
RUN \
  echo "[mysqld]"                           >/etc/mysql/conf.d/docker.cnf && \
  echo "bind-address = #{DB_BIND_ADDRESS}" >>/etc/mysql/conf.d/docker.cnf && \
  echo "skip-name-resolve"                 >>/etc/mysql/conf.d/docker.cnf && \
  echo "character-set-server = utf8"       >>/etc/mysql/conf.d/docker.cnf && \
  echo "init-connect = 'SET NAMES utf8'"   >>/etc/mysql/conf.d/docker.cnf


# Install runit service
RUN mkdir /etc/sv/mysql
COPY runit/mysql.sh /etc/sv/mysql/run
RUN chmod +x /etc/sv/mysql/run
RUN ln -s /etc/sv/mysql /etc/service/mysql

# Create mysql system tables
# RUN \
#   mysql_install_db && \
#   echo "mysql system tables installed"

# # Delete anonymous users and test table
# RUN \
#   mysql -e "DELETE FROM mysql.user WHERE User = '';" && \
#   mysql -e "DROP DATABASE test;" && \
#   echo "Anonymous mysql user account deleted and test db dropped."

# # Secure root account
# RUN \
#   mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" && \
#   mysql -e "UPDATE mysql.user SET Password = PASSWORD(\"${DB_ROOT_PASSWORD}\") WHERE User = 'root';" && \
#   mysql -e "FLUSH PRIVILEGES;" && \
#   echo "mysql root password set to ENV[MYSQL_ROOT_PASSWORD]"

# Define mountable directories
VOLUME "/var/lib/mysql"

EXPOSE  3306

CMD ["/sbin/my_init"]
