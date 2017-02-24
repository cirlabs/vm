#!/bin/bash

# Don't barf if no drives mounted, or if USB is lowercase
shopt -s nullglob
shopt -s nocaseglob

ASSET_PATH=$HOME/Desktop/TechRaking

# Iterate through all mounted USB drives
for drive in /Volumes/*NAME* ; do

   # rsync source to USB drive in background
   echo "Syncing $drive..."
   rsync -aviuPW --stats --inplace --modify-window=1 $ASSET_PATH "$drive"

done

# wait for all parallel rsyncs to finish
wait
