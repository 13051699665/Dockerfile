# Base Image
FROM centos:latest

# MAINTAINER
MAINTAINER chenqf <13051699665@163.com> 

# Put boost_1_59_0.tar.gz and mysql-5.7.13.tar.gz into /mnt and unpack /mnt/
ADD boost_1_59_0.tar.gz /mnt
ADD mysql-5.7.13.tar.gz /mnt

# Start the installation

# Install depend on the environment
RUN yum -y install make gcc-c++ cmake bison-devel  ncurses-devel

# Create users and groups
RUN groupadd mysql && useradd -r -g mysql -s /sbin/nologin -M mysql

# Create the directories
RUN mkdir -p /mnt/mysql/{data,logs,temp,conf}

# Allowed to mount the volume group
#VOLUME  ["/mnt/mysql/data", "/mnt/mysql/logs"]

# Access control Settings
RUN chown -R mysql:mysql /mnt/mysql

# WORKDIR
WORKDIR /mnt/mysql-5.7.13

# Compile the source code
RUN cmake . -DCMAKE_INSTALL_PREFIX=/mnt/mysql -DMYSQL_DATADIR=/mnt/mysql/data -DSYSCONFDIR=/etc/mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_USER=mysql -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/mnt/mysql/conf/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DENABLE_DOWNLOADS=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DWITH_DEBUG=0 -DMYSQL_MAINTAINER_MODE=0 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/mnt/boost_1_59_0

# Compile the installation
RUN make -j `grep processor /proc/cpuinfo | wc -l` && make install

# Copy the configuration file
COPY my.cnf /etc/mysql

# Environment variable is set
ENV PATH /mnt/mysql/bin:/mnt/mysql/lib:$PATH

# Initialize the set
#RUN mysqld --initialize-insecure --user=mysql --basedir=/mnt/mysql --datadir=/mnt/mysql/data --pid-file=/mnt/mysql/logs/mysql.pid --socket=/mnt/mysql/conf/mysql.sock

# Exposed service port
EXPOSE 3306
