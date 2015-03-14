# CouchDB

Builds a CouchDB container based on the [Phusion Baseimage](https://github.com/phusion/baseimage-docker):

* Ubuntu 14.04
* [CouchDB PPA](https://launchpad.net/~couchdb/+archive/ubuntu/stable) maintained by the CouchDB project
* Runit service for CouchDB

To run the container:

```sh
[sudo] docker run --name couchdb -p 5984:5984 lagotto/couchdb
```

## Maintainer
Martin Fenner <mfenner@plos.org>

## License
Released under the [APACHE 2.0 License](https://github.com/articlemetrics/Dockerfiles/blob/master/couchdb/LICENSE.md).
