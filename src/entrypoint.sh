#!/bin/bash

if ! grep -q $SSH_USERNAME /etc/group &> /dev/null; then
    echo "Creating group..."
    addgroup $SSH_USERNAME
fi

if ! id $SSH_USERNAME &> /dev/null; then
    echo "Creating user..."
    adduser --home $HOME_FOLDER --ingroup $SSH_USERNAME $SSH_USERNAME
fi

echo "Setting password..."
echo -e "$SSH_PASSWORD\n$SSH_PASSWORD" | passwd $SSH_USERNAME

echo "Setting home folder permissions..."
chown -R $SSH_USERNAME:$SSH_USERNAME $HOME_FOLDER

if [ -f $SETUP_SCRIPT_PATH ]; then
    echo "Running setup script..."
    bash $SETUP_SCRIPT_PATH
    echo "Finished running setup script..."
fi

echo "Starting ssh daemon..."

mkdir -p -m0755 /var/run/sshd
/usr/sbin/sshd -D
