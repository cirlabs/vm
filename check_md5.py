import hashlib
import glob
from os import path

def get_usbs():
    drives = glob.glob('/Volumes/NO NAME*')
    return drives

def md5(directory, fname):
    # Code adapted from http://stackoverflow.com/questions/3431825/generating-an-md5-checksum-of-a-file
    hash_md5 = hashlib.md5()
    filepath = path.join(directory, fname)
    with open(filepath, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

# desktop_path = path.expanduser("~/Desktop")

usb_paths = get_usbs()

# files = [
#     "TechRaking/NICAR17.ova",
#     "TechRaking/VirtualBox installers/VirtualBox-5.1.14-112924-Win.exe",
#     "TechRaking/VirtualBox installers/VirtualBox-5.1.14-112924-OSX.dmg",
#     "TechRaking/VirtualBox installers/Oracle_VM_VirtualBox_Extension_Pack-5.1.14-112924.vbox-extpack"
# ]

# source_md5s = {}
#
# for filename in files:
#     source_md5s[filename] = md5(desktop_path, filename)

source_md5s = {
    'TechRaking/NICAR17.ova': '84b5ad40eb75a23dfb3444134ad9a53d',
    'TechRaking/VirtualBox installers/VirtualBox-5.1.14-112924-OSX.dmg': 'eaa25a57698f7bb439b8e2d1295b62e6',
    'TechRaking/VirtualBox installers/Oracle_VM_VirtualBox_Extension_Pack-5.1.14-112924.vbox-extpack': '90285a09b6680a93a05d81b2db090dfd',
    'TechRaking/VirtualBox installers/VirtualBox-5.1.14-112924-Win.exe': '5d144b620e844d6d3eda77c330fdda87'
}

for usb in usb_paths:

    print "Checking {0}...".format(usb)

    for filename, md5_hash in source_md5s.iteritems():

        usb_md5 = md5(usb, filename)

        if usb_md5 != md5_hash:

            print "{0} checksum does not match for {1}.".format(filename, usb)
