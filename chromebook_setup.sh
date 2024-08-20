#!/bin/bash

# Set up Wi-Fi network
NETWORK_NAME="YourSecureWiFi"
NETWORK_PWD="YourSecurePassword"

# Connect to the Wi-Fi network using nmcli (NetworkManager Command Line Interface)
nmcli device wifi connect "$NETWORK_NAME" password "$NETWORK_PWD"
#nmcli device wifi connect "CorpWiFi" password "StrongPassword123"

# Update and install essential Linux packages (if Crostini is enabled)
if vmc list | grep -q "termina"; then
    echo "Crostini is enabled. Installing essential packages..."
    sudo apt-get update
    sudo apt-get install -y vim htop curl
    sudo apt-get install -y ufw fail2ban
else
    echo "Crostini is not enabled. Skipping package installation."
fi

# Enforce automatic updates and check update status
echo "Checking for system updates..."
update_engine_client --check_for_update
update_engine_client --status

# Security Hardening
echo "Applying security hardening settings..."
echo "Disabling guest mode..."
crossystem disable_guest_mode=1
echo "Enabling verified boot..."
crossystem dev_boot_signed_only=1
echo "Enabling password protection on wake/sleep..."
/usr/share/cros/settings/security_screen_lock.sh --enable
echo "Enforcing Chrome policies..."
# This would typically involve managing JSON policy files in /etc/opt/chrome/policies/managed/
# Example policy to enforce Safe Browsing:
# cat > /etc/opt/chrome/policies/managed/safe_browsing.json <<EOL
# {
#   "SafeBrowsingEnabled": true
# }
# EOL

# Set up logging for maintenance
LOGFILE="/var/log/chromebook_setup.log"
echo "Setup completed on $(date)" >> "$LOGFILE"
df -h >> "$LOGFILE"
top -b -n1 | head -n 10 >> "$LOGFILE"

# Backup user data (
echo "Backing up user data to Google Cloud Storage..."
gsutil rsync -r /home/chronos/user gs://company-backup-bucket/user-backup

echo "Chromebook setup and hardening complete. Log file: $LOGFILE"
