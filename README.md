vm
==
A data journalism virtual machine image for VirtualBox

## About

## Requirements
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (Choose your operating system)
- [VirtualBox Extpack](http://download.virtualbox.org/virtualbox/4.3.8/Oracle_VM_VirtualBox_Extension_Pack-4.3.8-92456.vbox-extpack) (download and click on it to install)
- `wget` (should be install for Linux and Mac users)
- `git`

## Installing VirtualBox
1. Download VirtualBox
2. Download the extension pack and click on it to install it on VirtualBox

## Installing the Virtual Machine
With the VirtualBox application installed, kick open terminal and type:
```bash
$ git clone git@github.com:cirlabs/vm.git
$ cd vm
$ bash install-vm.sh
```
`install-vm.sh` does the following:
1. Downloads the 3 GB virtual machine image from Amazon S3
2. Imports it into VirtualBox and configures it
3. Starts the virtual machine

## Help

## Contributing

## License
MIT. See [LICENSE]() for more information