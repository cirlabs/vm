#! /bin/bash

# adapted from http://unix.stackexchange.com/a/119260/105076

VOLUME_DIR='media'
USB_PATHS=()

for mtabline in `cat /etc/mtab | grep $VOLUME_DIR`; do
    device_path=`echo $mtabline | grep media`

    if [ $? == 0 ]; then
        touch `$device_path/file.txt`
    fi
done

echo $USB_PATHS
