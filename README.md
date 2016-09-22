# android-x86-vagrant

## this project is a work in progress

This repo contains scripts to create an android-x86_64 Virtualbox base box to use with Vagrant.


## I just want an Android VM

```
./boot.sh
```

Go get some coffee, this takes a while the first run (approx 20 min). 

## Creating the base box

Because there is no sshd in a standard Android installation, creating a Vagrant box from the android_x86 iso is not as simple as booting the image and exporting a boxfile. 

This repository contains a packer script that sets up an Android environment by sending keystrokes to the VM to perform the following steps: 

- Installs Android on disk in the VM
- Remaps MENU to the f1 key
- Boots the Linux in debug mode
- Remove the SetupWizard .apk files
- Boot Android
- Allow untrusted code to run
- Allow the browser to write files
- Download the linux deploy apk from github
- Install the apk
- Initialize the environment by starting the App once
- Write the settings to disk
- Authorize linux deploy as root
- Configure and install Archlinux in a chroot
- Autostart linux deploy
- Start the services (and the sshd daemon)

Build the box:
```
(cd packer && packer build -force template.json)
```

Because there is no feedback during the sending of keystrokes there could be timing issues which cause the script to fail. If that happens you can try to increase the waits between the keys. Also keep in mind that because keystrokes are sent to the VM without any feedback you shouldn't touch the GUI while the packer script is running.


## Starting the Vagrant

Once you've built the box you can start the Vagrant environment
```
vagrant up
```
