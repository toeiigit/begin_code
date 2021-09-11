#!/bin/bash

MONGODB_01={$1}
MONGODB_02={$2}
MONGODB_03={$3}

PORT_LIST=$(find . -name default.yml | xargs grep "mongodb://" | grep -v "#" | awk -F: {'print$6'} | awk -F/ {'print$1'} | sed -e '/^[[:space:]]*$/d')

for PORT in ${PORT_LIST}
do
    CONFIG_DBFILE=$(find . -name default.yml | xargs grep "mongodb://" | grep ${PORT} | awk {'print$1'} | sort -u)
    sed -i 's/gsbmymopbsitmsdb02:${PORT}/${1}:${PORT},${2}:${PORT},${3}:${PORT} ${CONFIG_DB}
done