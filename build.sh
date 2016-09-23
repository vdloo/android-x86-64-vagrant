#!/bin/sh

# build the boxfile from the iso
(cd packer && packer build -force template.json)

# test if there is a boxfile where we expected it
if [ ! -f packer/android-x86_64-virtualbox.box ]; then
    echo "Looks like something went wrong building the image. The building process is very flaky and fragile, maybe try again?"
    exit 1
fi;

# make sure we have a vagrant-catalog-generator checkout
if [ ! -d vagrant-catalog-generator ]; then
    git clone https://github.com/ByteInternet/vagrant-catalog-generator
else
    cd vagrant-catalog-generator
    git clean -xfd
    git reset --hard origin/master
    git pull origin master
    cd ..
fi;

# put the image in an images directory with an incremental release number
mkdir -p images
RELEASE=$(find images | wc -l)
mv packer/android-x86_64-virtualbox.box images/android-vagrant-${RELEASE}.box

# clean up old boxfiles, keep up to 5 releases
(cd vagrant-catalog-generator; export PYTHONPATH=.; \
    python bin/prune_boxfiles.py \
    --directory images --amount 5)

# generate the catalog.json with a filepath as url
(cd vagrant-catalog-generator; export PYTHONPATH=.; \
    python bin/generate_catalog.py \
    --directory images --base-url file://`pwd`/images \
    --description "android-x86_64 Vagrant box" --name android)
