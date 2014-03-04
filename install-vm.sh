#! bin/bash

## some necessary variables
vmname="Nicar Pre-K (Xubuntu)"
uuid=$(VBoxManage list vms | grep Nicar | grep -Eo '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
)
checksum="434db66814214674877454edabe04551  nicar-pre-k-2014.ova"

## fetch files
echo -e "Fetching Virtual Machine image\n=================\n"
wget https://s3-us-west-1.amazonaws.com/vms/nicar-pre-k-2014.ova

## make sure the files match
# echo -e "checking if the file matches the original checksum of " + $checksum + "\n================="
# get new checksum
# newchecksum=$(md5sum nicar-pre-k-2014.ova)

# if [[ $newchecksum -eq $checksum ]]; then
#     echo -e "Checksum matches. Continuing import!\n================="
# fi

## import the appliance into virtualbox and reinitialize the mac addresss
echo -e "Importing VM\n================="
VBoxManage import nicar-pre-k-2014.ova

# reinitialize the mac address
echo -e "modifying the MAC address ...\n================="
VBoxManage modifyvm $uuid --macaddress1 auto

## start the VM
echo -e "Starting Virtual Machine\n================="
VBoxManage startvm $uuid