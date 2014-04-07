vm
==
A data journalism virtual machine image for VirtualBox

## Features 
- csvkit
- Python
- Git
- Django
- SQLite
- MySQL
- PostgreSQL
- PostGIS
- PANDAS
- Ilene
- virtualenv/virtualenvwrapper
- QuantumGIS
- Node.js
- NPM
- Ruby
- Rails
- RVM
- Bower
- Grunt
- Fabric
- Yeoman

## Requirements
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (Choose your operating system)
- About 10 GB of disk space locally or on an external HDD/thumbdrive
- some time

## Installing the Virtual Machine

### Mac OS X / Linux

With VirtualBox installed, kick open terminal and type:
```bash
$ wget https://raw.githubusercontent.com/cirlabs/vm/master/install-vm.s
$ bash install-vm.sh
```
`install-vm.sh` does the following:

1. Installs the virtualbox extension pack
2. Downloads the 3 GB virtual machine image from Amazon S3
3. Imports it into VirtualBox and configures it
4. Starts the virtual machine

### Windows
Windows doesn't have bash so this script won't work. You can probably install [Cygwin](http://www.cygwin.com/) and try it there but I have not tested it. You're probably better off downloading the VirtualBox image directly from our AWS S3 bucket and importing it that way:

[Data Journalism VM file](https://s3-us-west-1.amazonaws.com/vms/nicar-pre-k-2014.ova) (3GB)

## Roll your own
Not enterested in using VirtualBox but want to bootstrap a Linux box for data journalism? Checkout [bootstrap.sh](https://github.com/cirlabs/vm/blob/master/bootstrap.sh).

## Help
[Open an issue](https://github.com/cirlabs/vm/issues)

## Thanks
Thanks to [xdissent](https://github.com/xdissent) for his work on [ievms](https://github.com/xdissent/ievms). I borrowed a lot of the VirtualBox fetch and check code from there.

## License
MIT. See [LICENSE](https://github.com/cirlabs/vm/blob/master/LICENSE) for more information
