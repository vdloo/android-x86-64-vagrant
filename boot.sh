#!/bin/sh

# build the image if it does not exist yet
if [ ! -f packer/android-x86_64-virtualbox.box ]; then
    (cd packer && packer build -force template.json)
fi;

# make sure the vagrant-vbguest plugin is installed so we can ensure it is disabled
vagrant plugin install vagrant-vbguest

# boot the VM
vagrant up
