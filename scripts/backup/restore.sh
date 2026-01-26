# File restore on machine from Local Backup

# Delete /etc

sudo cp /etc/hosts /etc/hosts.bak
sudo rm /etc/hosts

# Verify that it is deleted

ls /etc/hosts

# Restore from local backup

sudo rsync -aAX /backup/daily/latest/etc/hosts /etc/hosts

# Verify that the file is restored

ls -lah /etc/hosts

# Test system to verify it is working

ping -c 2 google.com


