#!/bin/bash
# Initialize the set
if [ -d /mnt/mysql/data ]&&[ -d /mnt/mysql/logs ]
  then
   chown -R mysql.mysql /mnt/mysql
   chown -R mysql.mysql /mnt/mysql
   mysqld --initialize-insecure --user=mysql --basedir=/mnt/mysql --datadir=/mnt/mysql/data --pid-file=/mnt/mysql/logs/mysql.pid --socket=/mnt/mysql/conf/mysql.sock
  else
   exit 1
fi
mysqld
