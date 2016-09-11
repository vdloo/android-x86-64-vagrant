# android-x86-vagrant

## this project is a work in progress

This repo contains scripts to create an android-x86_64 Virtualbox base box to use with Vagrant.

## Creating the base box

Because there is no sshd in a standard Android installation, creating a Vagrant box from the android_x86 iso is not as simple as booting the image and exporting a boxfile. 

This repository contains a packer script that sets up an Android environment by sending keystrokes to the VM to perform the following steps: 

- Install Android on disk in the VM
- Boot the Linux in debug mode
- Remove the SetupWizard .apk files
- Boot Android
- Allow untrusted code to run
- Allow the browser to write files
- Download the linux deploy apk from github TODO
- Install the apk TODO
- Authorize linux deploy as root TODO
- Configure and install Archlinux in a chroot TODO
- Start the services (and the sshd daemon) TODO

```
packer build -force template.json
```

Because there is no feedback during the sending of keystrokes there could be timing issues which cause the script to fail. If that happens you can try to increase the waits between the keys.

