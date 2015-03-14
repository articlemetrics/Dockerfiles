# Percona

Builds a Percona Server container based on the [Phusion Baseimage](https://github.com/phusion/baseimage-docker):

* Ubuntu 14.04
* Percona Server 5.6 installed from the [Percona APT Repository](http://www.percona.com/doc/percona-server/5.6/installation/apt_repo.html)
* Runit service for Percona

To run the container:

```sh
[sudo] docker run --name percona -p 3306:3306 lagotto/percona
```

## Maintainer
Martin Fenner <mfenner@plos.org>

## License
Released under the [GPL version 2 License](https://github.com/articlemetrics/Dockerfiles/blob/master/percona/LICENSE.md).
