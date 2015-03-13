FROM phusion/baseimage:latest
MAINTAINER Martin Fenner <mfenner@plos.org>

CMD ["/sbin/my_init"]

# Install CouchDB via official PPA
RUN apt-get update
RUN apt-get install -y software-properties-common -y
RUN sudo add-apt-repository ppa:couchdb/stable -y
RUN sudo apt-get update -y
RUN apt-get install -y couchdb

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN  sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /etc/couchdb/default.ini
RUN mkdir /var/run/couchdb
RUN chown -R couchdb /var/run/couchdb
RUN chmod -R 755 /var/run/couchdb

# Install runit service
RUN mkdir /etc/service/couchdb
ADD runit/couchdb.sh /etc/service/couchdb/run

VOLUME ["/var/log/couchdb", "/var/lib/couchdb", "/etc/couchdb"]

EXPOSE  5984
