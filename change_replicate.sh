#!/bin/bash

MONGODB_01=${1:-"$(hostname | cut -b -15)db01.cloud"}
MONGODB_02=${2:-"$(hostname | cut -b -15)db02.cloud"}
MONGODB_03=${3:-"$(hostname | cut -b -15)db03.cloud"}

PORT_LIST=$(find . -name default.yml | xargs grep "mongodb://" | grep -v "#" | awk -F: {'print$6'} | awk -F/ {'print$1'} | sed -e '/^[[:space:]]*$/d' | sort -u)

for PORT in ${PORT_LIST}
do
        OLD_HOST_REP=$(find . -name default.yml | xargs grep "mongodb://" | grep -v "#" | awk -F@ {'print$2'} | awk -F/ {'print$1'} | grep ${PORT} | sed -e '/^[[:space:]]*$/d' | sort -u)
        for CONFIG_DBFILE in $(find . -name default.yml | xargs grep "mongodb://" | grep -v '#' | grep ${PORT} | awk -F: {'print$1'} | sort -u)
        do
            sed -i 's/${OLD_HOST_REP}/${MONGODB_01}:${PORT},${MONGODB_02}:${PORT},${MONGODB_03}:${PORT}/g' ${CONFIG_DBFILE}
            STATUS=$(echo $?)
            if [ ${STATUS} == '0' ]
            then
                echo "SUCCESS --> sed -i 's/${OLD_HOST_REP}/${MONGODB_01}:${PORT},${MONGODB_02}:${PORT},${MONGODB_03}:${PORT}/g' ${CONFIG_DBFILE}"
            else
                echo "Fail !!!!!"
            fi
        done
done