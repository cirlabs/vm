How-to
------
This guide will show you how to create a VirtualBox virtual machine from scratch, install Xubuntu on it and bootstrap it with all the latest and greatest software.

## Setup
- Download and install VirtualBox and the Extensions
    - https://www.virtualbox.org/wiki/Downloads

- Download the Xubuntu 18.04 .iso
    - http://xubuntu.org/getxubuntu/
    - Choose 32-bit as some folks may have old machines

- Follow VirtualBox instructions for installing VirtualBox on "Creating your first virtual machine" Section 1.7
    - http://www.virtualbox.org/manual/ch01.html
    - When asked about which virtual image type to use, choose VMDK
        - http://www.virtualbox.org/manual/ch05.html#vdidetails
    - Set storage to whatever you'd like. I recommend 30.00 GB to 2.00 T DYNAMICALLY ALLOCATED !important

    - Set the RAM (We suggest 2048 MB or 2GB)


- Start the virtual machine and navigate your file system to the path of the iso

- Follow the Xubuntu prompts to install the operating system on the file system
    - set the username and password
    - For techraking: `nicar` with the password `nicar`

- Set Up Guest Additions
    - Guest Additions will give you full resolution and filesystem sharing, which are quite nice in VMs
    - Log into the Xubuntu VM, and select Menu > Menu Bar > Menu Bar Settings, then toggle "Devices" and confirm with the green button to the right.
    - You should then see a "Devices" dropdown menu for VirtualBox, where you will select "Insert Guest Additions CD Image."
    - Go to the Terminal Emulator and `cd /media/nicar/VBox_GAs_6.0.4`, or whatever path you wind up with after tab-completing from `/nicar/`
    - run `sudo ./VBoxLinuxAdditions.run`, which will likely prompt you for your password.
    - Now, when you resize the VirtualBox window, it will auto-resize, and you won't see scrollbars along either axis.

## Bootstrap the box
- Fetch the bootstrap script by downloading it with `wget`. Open up terminal and type:
    - `$ wget https://raw.githubusercontent.com/cirlabs/vm/master/bootstrap.sh`
- make the script executable
    - `$ chmod +x bootstrap.sh`
- run the script WITHOUT a subprocess
    - `$ . ./bootstrap.sh`
        - See: http://stackoverflow.com/a/16011496/868724
    - NOTE: This'll take some time. The first commands to run are `apt-get update` and `apt-get upgrade`. These two commands will make sure the the operating systems has the latest and greatest security patches and features. These are key before installing the rest of the software.

## Export
1. Open VirtualBox
2. Navigate to *File > Export Appliance*
3. Select the Xubuntu virtual machine
4. Choose OVF 1.0 (2.0 is for cloud computing compatibility. While the latest standard, it's still buggy in other virtualization software like VMware. See: https://www.virtualbox.org/ticket/11160)
5. Press *Export*
