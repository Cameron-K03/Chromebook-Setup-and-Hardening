# Chromebook Setup and Hardening Script

## Overview

This script automates the initial setup and security hardening of a Chromebook, making it ready for deployment in an enterprise environment. It includes steps to connect to a secure Wi-Fi network, install essential Linux packages (if Crostini is enabled), enforce system updates, apply security settings, and back up user data to Google Cloud Storage.

## Features

- **Wi-Fi Configuration:** Automatically connects the Chromebook to a specified Wi-Fi network using `nmcli`.
- **Linux Package Installation:** Installs essential tools like `vim`, `htop`, `curl`, and security utilities like `ufw` and `fail2ban`, if the Crostini Linux container is enabled.
- **System Updates:** Forces a check for system updates to ensure the Chromebook is running the latest software.
- **Security Hardening:** Applies key security settings, including disabling guest mode, enabling verified boot, and requiring a password on wake/sleep.
- **Chrome Policies:** Provides a framework to enforce Chrome policies via JSON files, such as enabling Safe Browsing.
- **Logging:** Captures the setup process in a log file for auditing and troubleshooting purposes.
- **Data Backup:** Backs up user data to a specified Google Cloud Storage bucket.

## Usage

1. **Clone or Download the Script:**
   - Clone the repository or download the script directly to your Chromebook.

2. **Make the Script Executable:**
   ```bash
   chmod +x chromebook_setup.sh
3. **Run the Script:**
   - Execute the script with elevated privileges to perform the setup and hardening.
   ```bash
   sudo ./chromebook_setup.sh
4. **Customize as Needed:**
   - Before running the script, you can customize the Wi-Fi network details, backup destination, or any other settings directly in the script.
  
