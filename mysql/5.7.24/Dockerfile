# Base Image
FROM centos:latest

# MAINTAINER
MAINTAINER chenqf <13051699665@163.com> 

# Put boost_1_59_0.tar.gz and mysql-5.7.13.tar.gz into /mnt and unpack /mnt/
ADD mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz /mnt

# WORKDIR
WORKDIR /mnt

# Start the installation

# Install depend on the environment
RUN yum -y install libaio libaio-devel numactl
RUN cp -rf mysql-5.7.24-linux-glibc2.12-x86_64 mysql

# Create users and groups
RUN groupadd mysql && useradd -r -g mysql -s /sbin/nologin -M mysql

# Create the directories
RUN mkdir -p /mnt/mysql/{temp,conf}

# Access control Settings

# Allowed to mount the volume group
#VOLUME  ["/mnt/mysql/data", "/mnt/mysql/logs"]

# Copy the configuration file
COPY my.cnf /etc
COPY initialize.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/initialize.sh
RUN ln -s /usr/local/bin/initialize.sh /mnt/initialize.sh

# Environment variable is set
ENV PATH /mnt/mysql/bin:/mnt/mysql/lib:$PATH

ENTRYPOINT ["initialize.sh"]
# Exposed service port
EXPOSE 3306
CMD ["mysqld_safe"]
