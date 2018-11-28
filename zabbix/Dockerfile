# Base image
FROM centos:latest

# MAINTAINER
MAINTAINER chenqf <13051699665@163.com>

# Put and Unpack

ADD php-7.1.15.tar /mnt
ADD nginx-1.12.2.tar.gz /mnt 
ADD zabbix-4.0.0.tar.gz /mnt

# Install depend on the environment

# Install nginx1.12.2

# Create users and groups
RUN groupadd nginx && useradd -M -g nginx -s /sbin/nologin nginx

RUN yum install -y pcre pcre-devel openssl openssl-devel zlib zlib-devel gcc-c++
RUN cd /mnt/nginx-1.12.2 && ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx12/ --with-http_v2_module --with-http_ssl_module --with-http_sub_module --with-http_stub_status_module --with-http_gzip_static_module --with-pcre && make && make install

# Copy nginx configuration file
COPY nginx.conf /usr/local/nginx12/conf
ADD zabbixweb.tar.gz /usr/local/nginx12/html

# Install php7.1.15

RUN yum -y install php-mcrypt libmcrypt libmcrypt-devel  autoconf  freetype gd jpegsrc libmcrypt libpng libpng-devel libjpeg libxml2 libxml2-devel  curl curl-devel gd-devel libjpeg-devel libxml2-devel bzip2-devel libcurl-devel

# make and make install
RUN cd /mnt/php-7.1.15 && ./configure --prefix=/usr/local/php71  --with-config-file-path=/usr/local/php71/etc  --with-bz2  --with-curl  --enable-ftp  --enable-sockets  --disable-ipv6  --with-gd  --with-jpeg-dir=/usr/local/php71  --with-png-dir=/usr/local/php71  --with-freetype-dir=/usr/local/php71  --enable-gd-native-ttf  --with-iconv-dir=/usr/local/php71  --enable-mbstring  --enable-calendar  --with-gettext  --with-libxml-dir=/usr/local/php71  --with-zlib  --with-pdo-mysql=mysqlnd  --with-mysqli=mysqlnd  --with-mysqli=mysqlnd  --enable-dom  --enable-xml  --enable-fpm  --with-libdir=lib64  --enable-bcmath && make && make install

# Copy php configuration file
RUN cd /usr/local/php71/etc && cp -f php-fpm.conf.default php-fpm.conf && cp -f php-fpm.d/www.conf.default php-fpm.d/www.conf
COPY php.ini /usr/local/php71/etc/ 

# INnstall zabbix4.0.0

RUN yum -y install libpcre* libpthread*  OpenIPMI* libssh2* fping* libcurl* libevent* net-snmp* libxml2* java-devel mariadb-devel  unixODBC-devel
RUN cd /mnt/zabbix-4.0.0 && ./configure --prefix=/usr/local/zabbix --sysconfdir=/usr/local/zabbix/etc --enable-server --enable-proxy --enable-agent  --with-net-snmp --with-libcurl --with-libxml2  --enable-ipv6 --enable-java --with-ssh2 --with-iconv --with-openipmi --with-openssl  --with-mysql && make && make install

# System installation support Chinese
RUN echo 'LANG="zh_CN.UTF-8"' >> /etc/locale.conf && echo 'export LC_ALL="zh_CN.UTF-8"' >> /etc/profile && source /etc/profile
RUN yum -y install kde-l10n-Chinese telnet && yum -y reinstall glibc-common && yum clean all  && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
# The new log storage paths
RUN mkdir -p /usr/local/zabbix/{logs,var}

# Copy zabbix server configuration file
COPY zabbix_server.conf /usr/local/zabbix/etc/

# Using scripts run multiple processes
COPY startize.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/startize.sh
#RUN startize.sh

# Start php nginx zabbix
ENTRYPOINT ["/usr/local/nginx12/sbin/nginx", "-g", "daemon off;"]
# Exposed service port
EXPOSE 80
