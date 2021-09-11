#!/bin/bash

LIST_DB_NAME=$(find . -name default.yml | xargs grep "mongodb://" | grep -v "#" | grep "?" | awk -F@ {'print$2'} | awk -F/ {'print$2'} | awk -F'maxPoolSize' {'print$1'} | sed -e '/^[[:space:]]*$/d' | sort -u)
for DB_NAME in ${LIST_DB_NAME}
do
    for CONFIG_DBFILE in $(find . -name default.yml | xargs grep "mongodb://" | grep -v '#' | grep ${DB_NAME} | awk -F: {'print$1'} | sort -u)
    do
        REP_NAME=$(cat /data/Replicate_name.txt | grep "${DB_NAME}")
        sed -i 's/${DB_NAME}/${REP_NAME}\&/g' ${CONFIG_DBFILE}
        STATUS=$(echo $?)
        if [ ${STATUS} == '0' ]
            then
                echo "SUCCESS --> sed -i 's/${DB_NAME}/${REP_NAME}\&/g' ${CONFIG_DBFILE}"
            else
                echo "Fail !!!!!"
        fi
     done
done