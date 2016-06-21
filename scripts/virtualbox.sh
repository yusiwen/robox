#!/bin/bash

error() {
        if [ $? -ne 0 ]; then
                printf "\n\nvbox install failed...\n\n";
                exit 1
        fi
}


# Bail if we are not running inside VirtualBox.
if [[ `dmidecode -s system-product-name` != "VirtualBox" ]]; then
    exit 0
fi

# Install the Virtual Box Tools from the Linux Guest Additions ISO.
printf "\n\nInstalling the Virtual Box Tools.\n"

mkdir -p /mnt/virtualbox; error
mount -o loop /root/VBoxGuest*.iso /mnt/virtualbox; error

sh /mnt/virtualbox/VBoxLinuxAdditions.run; error
ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions; error

umount /mnt/virtualbox; error
rm -rf /root/VBoxGuest*.iso; error
