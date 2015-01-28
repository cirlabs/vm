#! bin/bash

# Cribbed from https://github.com/xdissent/ievms/blob/master/ievms.sh

## SETUP
## =================

# Caution is a virtue.
set -o nounset
set -o errtrace
set -o errexit
set -o pipefail

# ## Utilities
# Store vm filename and display name
remote_vm_filename="nicar-pre-k-2015.ova"
remote_vm_display_name="NICAR" # set when the VM is created in VirtualBox

# Store the original `cwd`.
orig_cwd=`pwd`

# Options passed to each `curl` command.
curl_opts=${CURL_OPTS:-""}

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
        curl ${curl_opts} -L "${2}" -o "${3}" || fail "Failed to download ${2} to ${vms_home}/${3} using 'curl', error code ($?)"
    fi
}

# ## General Setup

# Create the vms home folder and `cd` into it. The `INSTALL_PATH` env variable
# is used to determine the full path. The home folder is then added to `PATH`.
create_home() {
    local def_vms_home="${HOME}/.vms"
    vms_home=${INSTALL_PATH:-$def_vms_home}

    mkdir -p "${vms_home}"
    cd "${vms_home}"

    PATH="${PATH}:${vms_home}"

    # Move ovas and zips from a very old installation into place.
    mv -f ./ova/IE*/IE*.{ova,zip} "${vms_home}/" 2>/dev/null || true
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

        log "Installing Oracle VM VirtualBox Extension Pack from ${vms_home}/${archive}"
        VBoxManage extpack install "${archive}" || fail "Failed to install Oracle VM VirtualBox Extension Pack from ${vms_home}/${archive}, error code ($?)"
    fi
}

download_vm() {
    log "Checking for NICAR VM image"
    if [ ! -f "$vms_home/${remote_vm_filename}" ]; then
        ## fetch files
        log "Fetching Virtual Machine"
        wget https://s3-us-west-1.amazonaws.com/vms/${remote_vm_filename}

        log "saved to $vms_home/${remote_vm_filename}"

        ## make sure the files match
        # checksum="434db66814214674877454edabe04551 ${remote_vm_filename}"
        # echo -e "checking if the file matches the original checksum of " + $checksum + "\n================="
        # get new checksum
        # newchecksum=$(md5sum ${remote_vm_filename})

        # if [[ $newchecksum -eq $checksum ]]; then
        #     echo -e "Checksum matches. Continuing import!\n================="
        # fi
    fi
}

import_vm() {
    log "Check if Virtual machine is already installed"
    vm_name="Nicar Pre-K (Xubuntu)"
    if ! VBoxManage list vms | grep -Po '"Nicar.*"'; then
        # import the appliance into virtualbox and reinitialize the mac addresss
        log "Type path to install VM, followed by [ENTER]. Defaults to /home/$USER/VirtualBox VMs"
        # receive user input
        read user_path

        log "Importing VM"
        # set the user path, otherwise, import normally
        if ! $user_path; then
            VBoxManage import "$vms_home/${remote_vm_filename}" --vsys 0 --unit 11 --disk "$user_path/$vm_name/${remote_vm_filename}"
        else
            VBoxManage import "$vms_home/${remote_vm_filename}"
        fi

        # reinitialize the mac address
        uuid=$(VBoxManage list vms | grep ${remote_vm_display_name} | grep -Eo '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}')
        log "modifying the MAC address"
        VBoxManage modifyvm $uuid --macaddress1 auto
    fi
}

start_vm() {
    ## start the VM
    uuid=$(VBoxManage list vms | grep ${remote_vm_display_name} | grep -Eo '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}')
    log "Starting Virtual Machine"
    VBoxManage startvm $uuid
}

## BLASTOFF
check_system
create_home
check_virtualbox
check_version
check_ext_pack
download_vm
import_vm
start_vm
