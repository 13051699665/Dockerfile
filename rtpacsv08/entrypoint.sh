#!/bin/bash

# Startup Redis Server
/usr/bin/redis-server /etc/redis.conf &

# Startup Rtpacs
cd /home/rtpacs/webserver
java -Xms128m -Xmx2048m -Djava.library.path="/usr/lib64/vtk" org.springframework.boot.loader.JarLauncher
