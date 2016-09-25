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

# Install additional tools
pacman -S tar procps python2 --noconfirm
