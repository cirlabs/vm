#! /bin/bash
# =============================
# sync.sh
# Take a directory at a given path and rsync it to
# all mounted USB drives
#
# Tested ONLY on Ubuntu Linux
# https://github.com/cirlabs/vm/
#
# Author: Aaron Williams
# Email: awilliams@cironline.org
# ==============================
# adapted from http://unix.stackexchange.com/a/119260/105076

VOLUME_DIR='media'
ASSET_PATH=$HOME/Desktop/TechRaking

sync_all() {
    for mtabline in `cat /etc/mtab | grep $VOLUME_DIR`; do
        device_path=`echo $mtabline | grep media`

        if [ $? == 0 ]; then
            echo "Syncing ..."
            rsync -aviuPW --stats --no-compress --inplace --modify-window=1 $ASSET_PATH $device_path
        fi
    done
}

sync_all
