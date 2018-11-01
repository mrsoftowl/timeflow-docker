#!/bin/bash

set -e -u

IP=$(ifconfig en0 |awk /netmask/'{print $2}')
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

docker run --rm -it \
    -m 4000MB \
    -e  DISPLAY=$IP:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    timeflow

pkill -2 socat
