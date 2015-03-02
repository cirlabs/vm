#! /bin/bash

# adapted from http://unix.stackexchange.com/a/119260/105076

VOLUME_DIR='media'
ASSET_PATH=$HOME/Desktop/TechRaking

for mtabline in `cat /etc/mtab | grep $VOLUME_DIR`; do
    device_path=`echo $mtabline | grep media`

    if [ $? == 0 ]; then
        echo "Syncing ..."
        set -x
        rsync -aviuP $ASSET_PATH $device_path
        set +x
    fi
done
