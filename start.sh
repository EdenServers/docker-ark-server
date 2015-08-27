#!/bin/bash

#Setting up SFTP
if ! id -u "$USERNAME" >/dev/null 2>&1; then
    PASSWORD=$(perl -e 'print crypt($ARGV[0], "password")' $PASSWORD)
    useradd -d /server/ark --shell /usr/bin/rssh --password $PASSWORD $USERNAME
    chown -R $USERNAME:$USERNAME /server/ark
fi

/etc/init.d/ssh start

cd /server/ark/ShooterGame/Binaries/Linux/ && ./ShooterGameServer TheIsland?listen?SessionName=EdenServers?ServerAdminPassword=zamel -server -log
