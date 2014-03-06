#! bin/bash

# Cribbed from https://github.com/xdissent/ievms/blob/master/ievms.sh

## SETUP
## =================

# ## Utilities

# Print a message to the console.
log()  { printf "$*\n" ; return $? ; }

# Print an error message to the console and bail out of the script.
fail() { log "\nERROR: $*\n" ; exit 1 ; }

# Download a URL to a local file. Accepts a name, URL and file.
download() {
    if [[ -f "${3}" ]]
    then
        log "Found ${1} at ${3} - skipping download"
    else
        log "Downloading ${1} from ${2} to ${3}"
        curl ${curl_opts} -L "${2}" -o "${3}" || fail "Failed to download ${2} to ${ievms_home}/${3} using 'curl', error code ($?)"
    fi
}

# ## General Setup

# Create the ievms home folder and `cd` into it. The `INSTALL_PATH` env variable
# is used to determine the full path. The home folder is then added to `PATH`.
create_home() {
    local def_ievms_home="${HOME}/.ievms"
    ievms_home=${INSTALL_PATH:-$def_ievms_home}

    mkdir -p "${ievms_home}"
    cd "${ievms_home}"

    PATH="${PATH}:${ievms_home}"

    # Move ovas and zips from a very old installation into place.
    mv -f ./ova/IE*/IE*.{ova,zip} "${ievms_home}/" 2>/dev/null || true
}

# Check for a supported host system (Linux/OS X).
check_system() {
    kernel=`uname -s`
    case $kernel in
        Darwin|Linux) ;;
        *) fail "Sorry, $kernel is not supported." ;;
    esac
}

# Ensure VirtualBox is installed and `VBoxManage` is on the `PATH`.
check_virtualbox() {
    log "Checking for VirtualBox"
    hash VBoxManage 2>&- || fail "VirtualBox command line utilities are not installed, please (re)install! (http://virtualbox.org)"
}

# Determine the VirtualBox version details, querying the download page to ensure
# validity.
check_version() {
    local version=`VBoxManage -v`
    major_minor_release="${version%%[-_r]*}"
    local major_minor="${version%.*}"
    local dl_page=`curl ${curl_opts} -L "http://download.virtualbox.org/virtualbox/" 2>/dev/null`

    if [[ "$version" == *"kernel module is not loaded"* ]]; then
        fail "$version"
    fi

    for (( release="${major_minor_release#*.*.}"; release >= 0; release-- ))
    do
        major_minor_release="${major_minor}.${release}"
        if echo $dl_page | grep "${major_minor_release}/" &>/dev/null
        then
            log "Virtualbox version ${major_minor_release} found."
            break
        else
            log "Virtualbox version ${major_minor_release} not found, skipping."
        fi
    done
}

# Check for the VirtualBox Extension Pack and install if not found.
check_ext_pack() {
    log "Checking for Oracle VM VirtualBox Extension Pack"
    if ! VBoxManage list extpacks | grep "Oracle VM VirtualBox Extension Pack"
    then
        check_version
        local archive="Oracle_VM_VirtualBox_Extension_Pack-${major_minor_release}.vbox-extpack"
        local url="http://download.virtualbox.org/virtualbox/${major_minor_release}/${archive}"

        download "Oracle VM VirtualBox Extension Pack" "${url}" "${archive}"

        log "Installing Oracle VM VirtualBox Extension Pack from ${ievms_home}/${archive}"
        VBoxManage extpack install "${archive}" || fail "Failed to install Oracle VM VirtualBox Extension Pack from ${ievms_home}/${archive}, error code ($?)"
    fi
}



# Install virtualbox
echo -e "Installing VirtualBox, VirtualBox guest additions and extension pack\n=============================="
sudo apt-get -qq install virtualbox 






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