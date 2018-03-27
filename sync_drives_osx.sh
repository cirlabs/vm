#!/bin/bash
# Code adapted from http://stackoverflow.com/questions/34866646/most-efficient-way-to-copy-data-to-multiple-usb-drives-in-os-x
# Don't barf if no drives mounted, or if USB is lowercase
shopt -s nullglob
shopt -s nocaseglob

ASSET_PATH=$HOME/nicar18
echo "$ASSET_PATH"
# Iterate through all mounted USB drives
for drive in /Volumes/*NAME* ; do

   # rsync source to USB drive in background
   echo "Syncing $drive..."
   rsync -aviuPW --stats --inplace --modify-window=1 --exclude=.DS_Store $ASSET_PATH "$drive"

done

# wait for all parallel rsyncs to finish
wait
