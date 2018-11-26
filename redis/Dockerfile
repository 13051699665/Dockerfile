# Base Image
FROM centos:latest

# MAINTAINER
MAINTAINER chenqf<13051699665@163.com>

# Install depend on the environment
RUN yum -y install gcc-c++ patch readline readline-devel zlib zlib-devel && yum -y install libyaml-devel libffi-devel openssl-devel make && yum -y install bzip2 autoconf automake libtool bison iconv-devel sqlite-devel

# Create users and groups
RUN groupadd redis && useradd -r -g redis -s /sbin/nologin -M redis

# WORKDIR
WORKDIR /mnt

# Upload and unpack
ADD redis-4.0.11.tar.gz .
ADD rubygems-2.7.7.tar.gz .
ADD ruby-2.4.5.tar.gz .
COPY redis-4.0.2.gem /mnt

# Copy the configuration file
RUN mkdir -p /mnt/redis-cluster/redis/{conf,run,logs}
COPY redis.conf /mnt/redis-cluster/redis/conf

# install redis4.0.11
RUN cd /mnt/redis-4.0.11 && make MALLOC=libc PREFIX=/mnt/redis-cluster/redis install
RUN ln -s /mnt/redis-cluster/redis/bin/* /usr/bin/

# install ruby2.4.5
RUN mkdir /usr/local/ruby-2.4.5 && chown -R redis.redis /usr/local/ruby-2.4.5
RUN cd /mnt/ruby-2.4.5 && ./configure --prefix=/usr/local/ruby-2.4.5 && make&&make install
RUN ln -s /usr/local/ruby-2.4.5/bin/* /usr/bin/

# install rubygems2.7.7
RUN cd rubygems-2.7.7 && ruby setup.rb

# install redis plugin
RUN gem install -l /mnt/redis-4.0.2.gem

# expose port
EXPOSE 16379

#Running
ENTRYPOINT ["/mnt/redis-cluster/redis/bin/redis-server", "/mnt/redis-cluster/redis/conf/redis.conf"]
#CMD ["/mnt/redis-cluster/redis/bin/redis-server", "/mnt/redis-cluster/redis/conf/redis.conf"]
