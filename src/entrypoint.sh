#!/bin/bash
set -e

if ! getent group "$SSH_USERNAME" > /dev/null 2>&1; then
    echo "Creating group..."
    groupadd "$SSH_USERNAME"
fi

if ! id "$SSH_USERNAME" > /dev/null 2>&1; then
    echo "Creating user..."
    useradd \
        --create-home \
        --home-dir "$HOME_FOLDER" \
        --gid "$SSH_USERNAME" \
        --shell /bin/bash \
        "$SSH_USERNAME"
fi

echo "Setting password..."
echo "$SSH_USERNAME:$SSH_PASSWORD" | chpasswd

echo "Setting home folder permissions..."
chown -R "$SSH_USERNAME:$SSH_USERNAME" "$HOME_FOLDER"

if [ -f "$SETUP_SCRIPT_PATH" ]; then
    echo "Running setup script..."
    bash "$SETUP_SCRIPT_PATH"
    echo "Finished running setup script..."
fi

echo "Starting ssh daemon..."

mkdir -p -m0755 /var/run/sshd
/usr/sbin/sshd -D
