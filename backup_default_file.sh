#!/bin/bash

CONFIG_FILE=$(find . -name default.yml)

cd /data
for i in ${CONFIG_FILE}
do
    cp -p $i $i.bak$(date "+%Y%m%d")
done