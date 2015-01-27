How-to
------
This guide will show you how to create a virtualbox virtual machine from scratch, install Xubuntu on it and bootstrap with all the latest and greatest software.

## Setup
- Download and install VirtualBox and the Extensions
    - https://www.virtualbox.org/wiki/Downloads

- Download the Xubuntu 14.04 .iso
    - http://xubuntu.org/getxubuntu/
    - Choose 32-bit as some folks may have old machines

- Follow VirtualBox instructions for installing virtualbox on "Creating your first virtual machine" Section 1.7
    - http://www.virtualbox.org/manual/ch01.html
    - When asked about which virtual image type to use, choose VMDK
        - http://www.virtualbox.org/manual/ch05.html#vdidetails
    - Set storage to whatever you'd like. I recommend 30.00 GB to 2.00 T DYNAMICALLY ALLOCATED !important

    - Set the RAM (We suggest 2048 MB or 2GB)


- Start the virtual machine and navigate your file system to the path of the iso

- Follow the Xubuntu prompts to install the operating system on the file system
    - set the username and password
    - For techraking: `nicar` with the password `nicar`

- Setup Guest Additions
    - Guest Additions will give you full resolution and filesystem sharing, which are quite nice in VMs
    - Log into the Xubuntu VM, open up the terminal and run this command:
        - `sudo apt-get install virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11`
    - Restart the VM to have a theorically native resolution supported virtual machine

## Bootstrap the box
- Fetch the bootstrap script by downloading it with `wget`. Open up terminal and type:
    - `$ wget https://raw.githubusercontent.com/cirlabs/vm/master/bootstrap.sh`
- make the script executable
    - `$ chmod +x bootstrap.sh`
- run the script WITHOUT a subprocess
    - `$ . ./bootstrap.sh`
        - See: http://stackoverflow.com/a/16011496/868724
    - NOTE: This'll take some time. The first commands to run are `apt-get update` and `apt-get upgrade`. These two commands will make sure the the operating systems has the latest and greatest security patches and features. These are key before installing the rest of the software.

## Extra changes
Here are some last configuration changes to do after `bootstrap.sh` finishes executing.

- Configure PostgreSQL

```bash
$ sudo su - postgres
$ "CREATE USER nicar SUPERUSER;" | psql -d postgres
$ exit
```
