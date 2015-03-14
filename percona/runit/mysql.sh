#!/bin/sh
exec /sbin/setuser mysql /usr/bin/mysqld_safe >>/var/log/mysql_exec.log 2>&1
