#!/bin/bash
sudo pacman -Syyu --noconfirm
sudo pacman -S iptables libnftnl libmnl  # fix missing packages
sudo pacman -S htop vim rsync git iproute2 tar procps --noconfirm
sudo rm -f /var/lib/pacman/db.lck
