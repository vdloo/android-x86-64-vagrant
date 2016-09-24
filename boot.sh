#!/bin/sh

# test if there is a catalog.json
if [ ! -d $HOME/.vagrant.d/boxes/android/ ]; then
    ./build.sh  # build the image if none exists
fi;

# Install vagrant-vbguest so we can explicitly disable it
vagrant plugin install vagrant-vbguest

# boot the Vagrant
vagrant up
