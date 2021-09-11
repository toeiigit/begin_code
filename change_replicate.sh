#!/bin/bash

MONGODB_01={$1}
MONGODB_02={$2}
MONGODB_03={$3}

PORT_LIST=$(find . -name default.yml | xargs grep "mongodb://" | grep -v "#" | awk -F: {'print$6'} | awk -F/ {'print$1'} | sed -e '/^[[:space:]]*$/d')

for PORT in ${PORT_LIST}
do
    OLD_HOST_REP=$(find . -name default.yml | xargs grep "mongodb://" | grep -v '#' | grep ${PORT} | awk -F@ {'print$2'} | awk -F: {'print$1'})
    CONFIG_DBFILE=$(find . -name default.yml | xargs grep "mongodb://" | grep -v '#' | grep ${PORT} | awk {'print$1'} | sort -u)
    sed -i 's/${OLD_HOST_REP}:${PORT}/${MONGODB_01}:${PORT},${MONGODB_02}:${PORT},${MONGODB_03}:${PORT}/g' ${CONFIG_DB}
done