vm
--
A Linux-powered data journalism virtual machine image for VirtualBox. Meant for beginners and/or people interested in learning the data journalism stack. Direct link to the image: [NICAR17.ova](https://s3.amazonaws.com/techraking/NICAR17/NICAR17.ova) (3GB; MD5: 30b8e6836a05affd0c2c3c72e883e908). Want to see what we've installed? Checkout the [manifest](manifest.md).

## Quickstart
With VirtualBox installed, kick open Terminal, paste the below command and press enter:

via `curl` (Mac OS X):
```bash
curl - L https://raw.githubusercontent.com/cirlabs/vm/master/install-vm.sh | sh
```
via `wget` (Linux)
```bash
$ wget --no-check-certificate https://raw.githubusercontent.com/cirlabs/vm/master/install-vm.sh -O - | sh
```

See [PACKAGE](PACKAGE) for installed software and login details.

## Features
The [Xubuntu 18.04](http://xubuntu.org/) operating system and a bunch of libraries commonly used by data journalists like:
- IPython
- Django
- SQLite, MySQL, PostgreSQL/PostGIS
- pandas
- QGIS
- csvkit

See [PACKAGE](PACKAGE) for full list

## Requirements
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) Version 5.0 or greater (Choose your operating system).
- About 10 GB of disk space locally or on an external HDD/thumb drive
- Time

## Installing the Virtual Machine

### Mac OS X / Linux
1. Download the script: [VM-2.0.1.zip](https://github.com/cirlabs/vm/archive/2.0.1.zip)
2. Extract the .zip file. You should see a file called `install-vm.sh` inside the folder.
3. Open Terminal. For Mac OS X, go to `Applications/Utilities/Terminal.app`. For Linux, press __CTRL+ALT+T__ to open it.
4. In Terminal, type `bash` and the path to `install-vm.sh`. The easiest way to do this is to type `bash` and then *drag-and-drop* `install-vm.sh` into the terminal prompt. You should have something like __`bash /Users/username/Downloads/VM-2.0/install-vm-sh`__.
5. Press [ENTER] and follow the instructions


`install-vm.sh` does the following:

1. Installs the VirtualBox extension pack
2. Downloads the 3 GB virtual machine image from Amazon S3
3. Imports it into VirtualBox and configures it
4. *(Optional)* Prompts user to select path to install virtual machine, e.g., `/Volumes/my-external-harddive/vms/`
5. Starts the virtual machine

### Windows users
Follow the instructions in [INSTALL](INSTALL.md)


## Roll your own
Not interested in using VirtualBox but want to bootstrap a Linux box for data journalism? Checkout [bootstrap.sh](bootstrap.sh).

## Cleanup
The 3 GB .ova file should be saved to `~/.vms`. You can remove it, as well as any other files, to regain that disk space back. You can also remove the `install-vm.sh` file.

## Limitations / Notes
- The VM will have a 800x600 screen resolution on startup. There are ways to make your VM fit the size of your host display but that goes on beyond the scope of this project. See [VirtualBox Manual 1.8.5. Resizing the machine's window](https://www.virtualbox.org/manual/ch01.html#intro-resize-window) for more details. Do note that installing VirtualBox Guest Additions only works for Windows and Linux users. Sorry Mac folks.

- This VM is meant as a place to practice and learn about data journalism and software development. It's running a lightweight Linux distribution and uses just enough RAM to not be a headache. While it is my hope you use this VM to learn and create some awesome projects, my greater hope would be that you abandon the VM altogether and configure your laptop directly with either Linux or whatever OS you prefer. Again, more than anything, this is more of a teaching tool than a fully supported out-of-the-box rig. That could change in the future, but that is the focus of this project as of now.

## Help
[Open an issue](https://github.com/cirlabs/vm/issues)

## Thanks
Thanks to [xdissent](https://github.com/xdissent) for his work on [ievms](https://github.com/xdissent/ievms). I borrowed a lot of the VirtualBox fetch and check code from there.

## License
MIT. See [LICENSE](https://github.com/cirlabs/vm/blob/master/LICENSE) for more information
