# Credit: https://github.com/13051699665/Dockerfile

# Base Image
FROM centos:centos7.6.1810

# MAINTAINER
MAINTAINER chenqf<13051699665@163.com>

# Setting Time Zone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo 'Asia/Shanghai' >/etc/timezone

# ADD yum repo
RUN rm -rf /etc/yum.repos.d/*
ADD ./CentOS-Base.repo /etc/yum.repos.d
ADD ./epel.repo /etc/yum.repos.d
ADD pip-package-rtpacs /pip-package-rtpacs
COPY which /usr/bin/

# Install depend on the environment
RUN yum clean all \
 && yum -y install gcc gcc-c++ zlib zlib-devel openssl openssl-devel curl java-openjdk kde-l10n-Chinese \
 && yum -y install python-pip python-devel \
 && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
# ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8

# Install Redis
RUN yum -y install redis \
 && echo "requirepass 81977100" >> /etc/redis.conf

# Install VTK 
RUN yum -y install vtk vtk-devel \
 && echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/vtk" >> /etc/profile

# Install python libary
RUN pip install --upgrade --no-index --find-links="/pip-package-rtpacs/" pip \
 && pip install  --no-index --find-links="/pip-package-rtpacs/" numpy nibabel \
 && pip install -I --no-index --find-links="/pip-package-rtpacs/" nose \
 && pip install -I --no-index --find-links="/pip-package-rtpacs/" dicom2nifti \
 && pip install -I --no-index --find-links="/pip-package-rtpacs/" pyparsing \
 && pip install  --no-index --find-links="/pip-package-rtpacs/" SimpleITK matplotlib networkx scikit-image \
 && rm -rf /pip-package-rtpacs
#COPY ./.pip /root/
#RUN /usr/local/python36/bin/python3.6 -m pip --no-cache-dir install --upgrade pip \ 
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install numpy \
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install pandas \
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install pillow \
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install sklearn \
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install antspyx \
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install scikit-image \
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install webcolors \
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install plotly \
 &&/usr/local/python36/bin/python3.6 -m pip --no-cache-dir install matplotlib \
 && rm -rf ~/.cache/pip

# Clean Cache     
RUN yum clean all&&rm -rf /var/cache/yum

# Seting Project
COPY ./entrypoint.sh /usr/local/bin
COPY ./Dockerfile /

# Exposed service port
EXPOSE 8006/tcp 8002/tcp 11122/tcp

ENTRYPOINT ["sh", "entrypoint.sh"]
