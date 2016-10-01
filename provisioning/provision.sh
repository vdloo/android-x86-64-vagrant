#!/usr/bin/env sh

# make sure the keys from the ssh agent can log in as root
mkdir -p /root/.ssh/
touch /root/.ssh/authorized_keys
if ssh-add -L >/dev/null 2>/dev/null; then
    auth_keys_file='/root/.ssh/authorized_keys'
    agent_keys=$(ssh-add -L | awk '!NF || !seen[$0]++' "$auth_keys_file" -)
    echo "$agent_keys" > "$auth_keys_file"
fi

# Fix pacman by force-reinstalling python, sometimes it is b0rked after packaging
rm -f /var/lib/pacman/db.lck
pacman -Rsc python --noconfirm 2> /dev/null
pacman -S --force python --noconfirm 2> /dev/null
# Ensure additional tools are installed
pacman -S inetutils htop vim rsync git iproute2 racket-minimal \
	python3 python2 tar procps libmnl libnftnl popt gpm --force --noconfirm

NEWHOSTNAME=$(uuidgen | sed 's/-//g' | head -c 16)
echo $NEWHOSTNAME > /etc/hostname
hostname -F /etc/hostname
